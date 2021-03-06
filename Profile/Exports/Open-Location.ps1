Set-Alias browse Open-Location
function Open-Location {
    [CmdletBinding()]
    param(
        [ValidateSet("InstallPath", "ProfileModule", "Profile", "CurrentDirectory", "PowerShellScripts", "Scripts", "Documents", "Desktop", "Computer", "GitHub")]
        [Parameter(Position = 1)]$location = "CurrentDirectory",
        [Parameter(ParameterSetName = "Shell")][switch]$shell,
        [Parameter(ParameterSetName = "Shell")]$scriptBlock
    )
    
    $type = "Folder"
    $path = switch ($location)
    {
        "InstallPath" { $ProfileConfig.General.InstallPath }
        "Profile" { Split-Path $PROFILE }
        "ProfileModule" { Get-Module Profile | select -ExpandProperty ModuleBase }
        "CurrentDirectory" { $pwd }
        "PowerShellScripts" { $ProfileConfig.General.PowerShellScriptsFolder }
        "Scripts" { $ProfileConfig.General.PowerShellScriptsFolder }
        "Documents" { [Environment]::GetFolderPath( [Environment+SpecialFolder]::MyDocuments) }
        "Desktop" {  [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop) }
        "Computer" { "::{20d04fe0-3aea-1069-a2d8-08002b30309d}" }
        "GitHub" {
        	$type = "URL"
        	Push-Location $ProfileConfig.General.InstallPath
			try { $gitHubUrl = & git config --get remote.origin.url }
			finally { Pop-Location }
			$gitHubUrl
		}
    }
    if ($type -eq "URL") { Open-UrlWithDefaultBrowser $path }
    elseif ($type -eq "Folder") {
	    if (-not $shell) { & explorer $path }
	    else {
	    	Push-Location $path
	    	if ($scriptBlock) {
				& $scriptBlock
				Pop-Location
	    	}
 		}
	}
}
@{Function = "Open-Location"; Alias = "browse"}