"Configuring ConEmu Shell Integration..."
New-Item "HKCU:\Software\Classes\*\shell\Open ConEmu" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\*\shell\Open ConEmu" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\*\shell\Open ConEmu\command" -Value """$InstallPath\ConEmu\ConEmu.exe"" /cmd powershell.exe" -Type String -Force | Out-Null

New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open ConEmu" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\Directory\Background\shell\Open ConEmu" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open ConEmu\command" -Value """$InstallPath\ConEmu\ConEmu.exe=="" /cmd powershell.exe" -Type String -Force | Out-Null

New-Item "HKCU:\Software\Classes\Directory\shell\Open ConEmu" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\Directory\shell\Open ConEmu" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\Directory\shell\Open ConEmu\command" -Value """$InstallPath\ConEmu\ConEmu.exe"" /cmd powershell.exe" -Type String -Force | Out-Null

New-Item "HKCU:\Software\Classes\Drive\shell\Open ConEmu" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\Drive\shell\Open ConEmu" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\Drive\shell\Open ConEmu\command" -Value """$InstallPath\ConEmu\ConEmu.exe"" /cmd powershell.exe" -Type String -Force | Out-Null


"Configuring ConEmu Embedded Shell Integration..."
New-Item "HKCU:\Software\Classes\*\shell\Open ConEmu (Embedded)" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\*\shell\Open ConEmu (Embedded)" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\*\shell\Open ConEmu (Embedded)\command" -Value """$InstallPath\ConEmu\ConEmu.exe"" /inside /cmd powershell.exe" -Type String -Force | Out-Null

New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open ConEmu (Embedded)" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\Directory\Background\shell\Open ConEmu (Embedded)" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open ConEmu (Embedded)\command" -Value """$InstallPath\ConEmu\ConEmu.exe"" /inside /cmd powershell.exe" -Type String -Force | Out-Null

New-Item "HKCU:\Software\Classes\Directory\shell\Open ConEmu (Embedded)" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\Directory\shell\Open ConEmu (Embedded)" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\Directory\shell\Open ConEmu (Embedded)\command" -Value """$InstallPath\ConEmu\ConEmu.exe"" /inside /cmd powershell.exe" -Type String -Force | Out-Null

New-Item "HKCU:\Software\Classes\Drive\shell\Open ConEmu (Embedded)" -Force | Out-Null
New-ItemProperty "HKCU:\Software\Classes\Drive\shell\Open ConEmu (Embedded)" "Icon" -Value "$InstallPath\Support Files\Icons\PowerShellPrompt.ico" -Type String -Force | Out-Null
New-Item "HKCU:\Software\Classes\Drive\shell\Open ConEmu (Embedded)\command" -Value """$InstallPath\ConEmu\ConEmu.exe"" /inside /cmd powershell.exe" -Type String -Force | Out-Null