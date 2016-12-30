function Read-TimesheetData
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript({Test-Path $_ -PathType Leaf})]
		[string]$Path
	)

	return Import-Csv -Path $Path
}