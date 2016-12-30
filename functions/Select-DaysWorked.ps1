function Select-DaysWorked
{
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[PSObject]$InputObject
	)

	$daysWorked = $InputObject | ForEach-Object { $_.Start.Date } | Select-Object -Unique

	return $daysWorked
}