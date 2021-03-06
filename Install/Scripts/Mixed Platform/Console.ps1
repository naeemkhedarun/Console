Write-InstallMessage -EnterNewScope "Configuring Console"

$conEmuExecutable = Join-Path $InstallPath "Third Party\Console\ConEmu64.exe"
$conEmuCommandIcon = Join-Path $InstallPath "Support Files\Icons\CommandPrompt.ico"
$conEmuPowerShellIcon = Join-Path $InstallPath "Support Files\Icons\PowerShellPrompt.ico"

$sublimeTextExecutable = Join-Path $InstallPath "Third Party\Sublime Text\sublime_text.exe"

Get-ChildItem ".\Console" -Filter *.ps1 | Sort-Object Name | % { & $_.FullName }

Exit-Scope