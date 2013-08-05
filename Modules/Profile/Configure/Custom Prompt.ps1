Set-Alias prompt Write-Prompt
function Write-Prompt {
    $realLASTEXITCODE = $LASTEXITCODE

	$windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $windowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal $windowsIdentity
    if ($windowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) { $securityColour = "Red" }
    else { $securityColour = "Green" }

    if ((Split-Path $pwd -NoQualifier) -eq "\") { $path = Split-Path $pwd -Qualifier }
	else { $path = (Split-Path $pwd -Parent | Get-ChildItem -Filter (Split-Path $pwd -Leaf) -Force).Name }

	Write-Host -ForegroundColor $securityColour -NoNewLine "$path"
    Write-VcsStatus
    Write-Host -ForegroundColor $securityColour -NoNewLine "$"

    $global:LASTEXITCODE = $realLASTEXITCODE
	return " "
}