function Group-TimesheetData
{
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[DateTime[]]$DaysWorked,

		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[PSObject]$TimesheetData
	)

	$groupedData = @()
	foreach ($day in $DaysWorked)
	{
		$dataGroup = @()
		Write-Verbose -Message ($day)
		$dataGroup += $TimesheetData | Where-Object {$_.Start -ge $day -and $_.End -lt $day.AddDays(1)}

		Write-Verbose -Message ($dataGroup.Count)
		$groupedData += ,$dataGroup

		Write-Verbose -Message ("Group Array Size" + $groupedData.Count)
	}

	return $groupedData
}