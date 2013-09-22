Invoke-InstallStep "Configuring Console Shell Integration" {
	New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open Console" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\Directory\Background\shell\Open Console" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open Console\command" -Value """$conEmuExecutable""" -Type String -Force | Out-Null

	New-Item "HKCU:\Software\Classes\*\shell\Open Console" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\*\shell\Open Console" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\*\shell\Open Console\command" -Value """$conEmuExecutable""" -Type String -Force | Out-Null

	New-Item "HKCU:\Software\Classes\Folder\shell\Open Console" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\Folder\shell\Open Console" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\Folder\shell\Open Console\command" -Value """$conEmuExecutable""" -Type String -Force | Out-Null

	New-Item "HKCU:\Software\Classes\Drive\shell\Open Console" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\Drive\shell\Open Console" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\Drive\shell\Open Console\command" -Value """$conEmuExecutable""" -Type String -Force | Out-Null
}

Invoke-InstallStep "Configuring Console Embedded Shell Integration" {
	New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open Console (Embedded)" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\Directory\Background\shell\Open Console (Embedded)" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\Directory\Background\shell\Open Console (Embedded)\command" -Value """$conEmuExecutable"" /inside" -Type String -Force | Out-Null

	New-Item "HKCU:\Software\Classes\*\shell\Open Console (Embedded)" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\*\shell\Open Console (Embedded)" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\*\shell\Open Console (Embedded)\command" -Value """$conEmuExecutable"" /inside" -Type String -Force | Out-Null

	New-Item "HKCU:\Software\Classes\Folder\shell\Open Console (Embedded)" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\Folder\shell\Open Console (Embedded)" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\Folder\shell\Open Console (Embedded)\command" -Value """$conEmuExecutable"" /inside" -Type String -Force | Out-Null

	New-Item "HKCU:\Software\Classes\Drive\shell\Open Console (Embedded)" -Force | Out-Null
	New-ItemProperty "HKCU:\Software\Classes\Drive\shell\Open Console (Embedded)" "Icon" -Value "$conEmuIcon" -Type String -Force | Out-Null
	New-Item "HKCU:\Software\Classes\Drive\shell\Open Console (Embedded)\command" -Value """$conEmuExecutable"" /inside" -Type String -Force | Out-Null
}