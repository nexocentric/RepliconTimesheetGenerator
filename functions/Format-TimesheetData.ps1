function Format-TimesheetData
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[PSObject]$InputObject
	)

	$formattedData = $InputObject |
		Sort-Object -Property Start |
		Where-Object { $_.Billable -eq "Yes" } |
		Select-Object -Property @{Name="Task"; Expression={$_.Name.Split(",")[0]}},
			@{Name="Plants"; Expression={Set-PlantsAffected -Name $_.Name}},
			@{Name="Start"; Expression={[DateTime]$_.Start}},
			@{Name="End"; Expression={[DateTime]$_.End}},
			Notes
	
	return $formattedData
}