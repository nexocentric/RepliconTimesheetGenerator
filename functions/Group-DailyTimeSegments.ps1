function Group-DailyTimeSegments
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[PSObject[]]$DaySummary,

		[PSObject]$NextSummary = $null
	)
	
	$DaySummary = $DaySummary | Sort-Object -Property End -Decending
	$daysLeft = $DaySummary | Where-Object { $_ -ne $NextSummary}
	$selected = $DaySummary[0]
	
	#end condition
	if ($selected -eq $null)
	{
		return
	}

	if ($NextSummary -ne $null)
	{
		$NextSummary.Start = Get-Date
		$NextSummary.End = Get-Date
	}
}