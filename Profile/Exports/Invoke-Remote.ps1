Set-Alias remote Invoke-Remote
function Invoke-Remote {
    [CmdletBinding(DefaultParameterSetName="Interactive")]
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $ComputerName,
        [ValidateSet("PowerShell", "RDC", "RDP")][Parameter(ParameterSetName="Interactive",Position=1)]
        $InteractiveType = "PowerShell",
        [Parameter(ValueFromRemainingArguments=$true,Mandatory=$true,ParameterSetName="PsExecCommand",Position=2)]
        $Command
    )

    if ($command) {    
        $psexecOutput = [IO.Path]::GetTempFileName()
        Write-Verbose "PsExec Output: $psexecOutput"

        $existingCommand = (Invoke-Command -ComputerName $ComputerName {
            param($Command)
            Get-Command -Name $Command[0] -CommandType Application -ErrorAction SilentlyContinue
         } -ArgumentList $Command) -eq $null
        if (-not $existingCommand) { $copyProgramSwitch = "-c" }
        
        & PsExec.exe -acceptEula \\$ComputerName $copyProgramSwitch $command 2>$psexecOutput

        Get-Content $psexecOutput | Select-Object -Last 3 | Select-Object -First 2
        if (-not $PSBoundParameters['Verbose']) {
            Remove-Item $psexecOutput -Force
        }
    }
    elseif ($InteractiveType -eq "PowerShell") {
        Enter-PSSession -ComputerName $ComputerName
    }
    elseif ($InteractiveType -eq "RDC" -or $InteractiveType -eq "RDP") {
    	$localDevicesPath = "HKCU:\Software\Microsoft\Terminal Server Client\LocalDevices"
    	if (-not (Test-Path $localDevicesPath)) {
   			New-Item $localDevicesPath -Force | Out-Null
   		}
   		$localDevices = Get-Item $localDevicesPath
   		if ($null -eq ($localDevices.GetValue($ComputerName))) {
   			# Automatically accept the security warning for new connections if it hasnt been seen before
   			New-ItemProperty $localDevicesPath $ComputerName -Value "5" -Type DWord -Force | Out-Null
   		}
    	
        & mstsc (Join-Path $InstallPath "Support Files\MSTSC\Default.rdp") /v:$ComputerName
    }
}                   
@{Function = "Invoke-Remote"; Alias = "remote"}