Set-Alias export Export-Helper
function Export-Helper
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)] [validateset("function","alias","var")] $type,
		[Parameter(Mandatory=$true)] $name,
		$value
	)
	# do switch here...
	if ($type -eq "function")
	{
		Set-item "function:script:$name" $value
		Export-ModuleMember -Function $name
	}
	elseif ($type -eq "alias")
	{
		Write-Host "Exporting $name $value"
		Set-Alias $name $value
		Export-ModuleMember -Alias $name
	}
	elseif ($type -eq "var")
	{
		$value = Get-Variable -Scope Script $name
		Set-Variable -Scope Script $name $value
		Export-ModuleMember -Variable $name
	}
}