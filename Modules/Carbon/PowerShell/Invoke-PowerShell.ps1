# Copyright 2012 Aaron Jensen
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function Invoke-PowerShell
{
    <#
    .SYNOPSIS
    Invokes a script block in a separate powershell.exe process.
    
    .DESCRIPTION
    If using PowerShell v2.0, the invoked PowerShell process can run under the .NET 4.0 CLR (using `v4.0` as the value to the Runtime parameter).

    If using PowerShell v3.0, you can *only* run script blocks under a `v4.0` CLR.  PowerShell converts script blocks to an encoded command, and when running encoded commands, PowerShell doesn't allow the `-Version` parameter for running PowerShell under a different version.  To run code under a .NET 2.0 CLR from PowerShell 3, use the `FilePath` parameter to run a specfic script.
    
    This function launches a PowerShell process that matches the architecture of the *operating system*.  On 64-bit operating systems, you can run under 32-bit PowerShell by specifying the `x86` switch).
    
    .EXAMPLE
    Invoke-PowerShell -Command { $PSVersionTable }
    
    Runs a separate PowerShell process which matches the architecture of the operating system, returning the $PSVersionTable from that process.  This will fail under 32-bit PowerShell on a 64-bit operating system.
    
    .EXAMPLE
    Invoke-PowerShell -Command { $PSVersionTable } -x86
    
    Runs a 32-bit PowerShell process, return the $PSVersionTable from that process.
    
    .EXAMPLE
    Invoke-PowerShell -Command { $PSVersionTable } -Runtime v4.0
    
    Runs a separate PowerShell process under the v4.0 .NET CLR, returning the $PSVersionTable from that process.  Should return a CLRVersion of `4.0`.
    
    .EXAMPLE
    Invoke-PowerShell -FilePath C:\Projects\Carbon\bin\Set-DotNetConnectionString.ps1 -ArgumentList '-Name','myConn','-Value',"'data source=.\DevDB;Integrated Security=SSPI;'"
    
    Runs the `Set-DotNetConnectionString.ps1` script with `ArgumentList` as arguments/parameters.
    
    Note that you have to double-quote any arguments with spaces.  Otherwise, the argument gets interpreted as multiple arguments.
    #>
    [CmdletBinding(DefaultParameterSetName='ScriptBlock')]
    param(
        [Parameter(Mandatory=$true,ParameterSetName='ScriptBlock')]
        [Alias('Command')]
        [ScriptBlock]
        # The command to run.
        $ScriptBlock,
        
        [Parameter(Mandatory=$true,ParameterSetName='FilePath')]
        [string]
        # The script to run.
        $FilePath,
        
        [object[]]
        [Alias('Args')]
        # Any arguments to pass to the command/scripts.
        $ArgumentList,
        
        [string]
        # Determines how output from the PowerShel command is formatted
        $OutputFormat,
        
        [Switch]
        # Run the x86 (32-bit) version of PowerShell, otherwise the version which matches the OS architecture is run, *regardless of the architecture of the currently running process*.
        $x86,
        
        [string]
        [ValidateSet('v2.0','v4.0')]
        # The CLR to use.  Must be one of v2.0 or v4.0.  Default is the current PowerShell runtime.
        $Runtime
    )
    
    $currentRuntime = 'v{0}.0' -f $PSVersionTable.CLRVersion.Major

    if( -not $Runtime )
    {
        $Runtime = $currentRuntime
    }

    if(  $PSCmdlet.ParameterSetName -eq 'ScriptBlock' -and $Runtime -eq 'v2.0' -and $PSVersionTable.PSVersion -ge '3.0' )
    {
        Write-Error ('PowerShell v{0} can''t run script blocks under .NET {1}. Please save your script block into a file and re-run Invoke-PowerShell using the `FilePath` parameter.' -f `
                        $PSVersionTable.PSVersion,$Runtime)
        return
    }

    $comPlusAppConfigEnvVarName = 'COMPLUS_ApplicationMigrationRuntimeActivationConfigPath'
    $activationConfigDir = Join-Path $env:TEMP ([IO.Path]::GetRandomFileName())
    $activationConfigPath = Join-Path $activationConfigDir powershell.exe.activation_config
    $originalCOMAppConfigEnvVar = [Environment]::GetEnvironmentVariable( $comPlusAppConfigEnvVarName )
    if( $currentRuntime -ne $Runtime )
    {
        $null = New-Item -Path $activationConfigDir -ItemType Directory
        @"
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <startup useLegacyV2RuntimeActivationPolicy="true">
    <supportedRuntime version="{0}" />
  </startup>
</configuration>
"@ -f $Runtime | Out-File -FilePath $activationConfigPath -Encoding OEM
        Set-EnvironmentVariable -Name $comPlusAppConfigEnvVarName -Value $activationConfigDir -ForProcess
    }
    
    $params = @{ }
    if( $x86 )
    {
        $params.x86 = $true
    }
    
    try
    {
        $psPath = Get-PowerShellPath @params
        if( $ArgumentList -eq $null )
        {
            $ArgumentList = @()
        }
        $powerShellArgs = @( '-NoProfile', '-NoLogo' )
        if( $OutputFormat )
        {
            $powerShellArgs += '-OutputFormat'
            $powerShellArgs += $OutputFormat
        }
        if( $PSCmdlet.ParameterSetName -eq 'ScriptBlock' )
        {
            & $psPath $powerShellArgs -Command $ScriptBlock -Args $ArgumentList
        }
        else
        {
            & $psPath $powerShellArgs -Command $FilePath $ArgumentList
        }
    }
    finally
    {
        if( Test-Path -Path $activationConfigDir -PathType Leaf )
        {
            Remove-Item -Path $activationConfigDir -Recurse -Force
        }

        if( Test-Path -Path env:$comPlusAppConfigEnvVarName )
        {
            if( $originalCOMAppConfigEnvVar )
            {
                Set-EnvironmentVariable -Name $comPlusAppConfigEnvVarName -Value $originalCOMAppConfigEnvVar -ForProcess
            }
            else
            {
                Remove-EnvironmentVariable -Name $comPlusAppConfigEnvVarName -ForProcess
            }
        }
    }
}
