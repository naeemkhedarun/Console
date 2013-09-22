Write-InstallMessage -EnterNewScope "Configuring Profile Hook"

Invoke-InstallStep "Setting up PowerShell Profile Directory" {
	$profileFolder = Split-Path $PROFILE.CurrentUserAllHosts -Parent
	if (!(Test-Path $profileFolder)) {
	    New-Item $profileFolder -Type Directory -Force | Out-Null
	}
	(Get-Item $profileFolder -Force).Attributes = 'Hidden'
}

$generatedProfileToken = "<# Custom Profile Hook #>"

$PROFILE | Get-Member -MemberType NoteProperty | % { $PROFILE | Select-Object -ExpandProperty $_.Name } | ? { (Test-Path $_) -and ((Get-Content $_ | Select-Object -First 1) -ne $generatedProfileToken) } | % {
    Write-InstallMessage -Type Warning "$_ exists, backing up to $($_ + ".bak")"
    Move-Item $_ ($_ + ".bak") -Force
}

Invoke-InstallStep "Creating Profile and adding hook" {
	New-Item $PROFILE.CurrentUserAllHosts -Type File -Force | Out-Null
	Add-Content $PROFILE.CurrentUserAllHosts `
@"
$generatedProfileToken
function Reset-Profile {
    Remove-Module Profile -ErrorAction SilentlyContinue
    Import-Module "$InstallPath\Profile\Profile.psd1" -ArgumentList "$InstallPath" -Force -Global
}
Reset-Profile
"@
}

Exit-Scope