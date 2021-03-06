param($InstallPath)
Set-StrictMode -Version Latest

Import-Module (Join-Path $PSScriptRoot InternalHelpers) -ArgumentList $InstallPath

Get-ChildItem "$PSScriptRoot\Configure" -Filter *.ps1 -Recurse | Sort-Object Name | % { & $_.FullName }

Get-ChildItem "$PSScriptRoot\Exports" -Filter *.ps1 -Recurse | Sort-Object DirectoryName, Name | % { . $_.FullName } | % {
	if ($_["Function"]) { $_.Function | % { Export-ModuleMember -Function $_ } }
	if ($_["Alias"]) {	$_.Alias | % { Export-ModuleMember -Alias $_ } }
}

$includeFile = Join-Path ([System.Environment]::GetFolderPath("MyDocuments")) "PowerShell Scripts\include.ps1"
if ((Test-Path $includeFile) -and -not ([String]::IsNullOrWhiteSpace([IO.File]::ReadAllText($includeFile)))) {
    Write-Host "Loading include file $includeFile..."
    . $includeFile | % {
		if ($_["Function"]) { $_.Function | % { Write-Host "Loading function $_..."; Export-ModuleMember -Function $_ } }
		if ($_["Alias"]) {	$_.Alias | % { Write-Host "Loading alias $_...";  Export-ModuleMember -Alias $_ } }
	}
}

Export-ModuleMember -Variable ProfileConfig