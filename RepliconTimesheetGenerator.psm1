if ($PSVersionTable.PSVersion.Major -ge 5)
{
	$script:IgnoreErrorPreference = 'Ignore'
}
else
{
	$script:IgnoreErrorPreference = 'SilentlyContinue'
}

$moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path

"${moduleRoot}\functions\*.ps1" |
Resolve-Path |
Where-Object { -not ($_.ProviderPath.ToLower().Contains(".tests.")) } |
ForEach-Object { . $_.ProviderPath }


$dailySummaryMethod = {
	param($object)

	if ($this.DateWorked -ne $object.DateWorked) { return $false; }
	if ($this.HoursWorked -ne $object.HoursWorked) { return $false; }
	if ($this.TimeDistribution -ne $object.TimeDistribution) { return $false; }
	if ($this.CommentSummary -ne $object.CommentSummary) { return $false; }

	return $true
}

$commentsEqualMethod = {
	param($object)

	if ($this.CommentSummary -ne $object.CommentSummary) { return $false; }

	return $true
}

$dailySummaryPrototype = @{
	DateWorked = [DateTime];
	HoursWorked = [TimeSpan];
	TimeDistribution = @{
		KFI = 0;
		KFE = 0;
		KSP = 0;
	};
	CommentSummary = [string];
}

$DailySummary = New-Object -TypeName PSObject -Property $dailySummaryPrototype
$DailySummary = Add-Member -InputObject $DailySummary -MemberType ScriptMethod -Name SummariesAreEqual -Value $dailySummaryMethod
$DailySummary = Add-Member -InputObject $DailySummary -MemberType ScriptMethod -Name CommentsAreEqual -Value $commentsEqualMethod

Export-ModuleMember -Variable DailySummary

Export-ModuleMember -Function New-TimesheetSummary
Export-ModuleMember -Function Read-TimesheetData
Export-ModuleMember -Function Format-TimesheetData
Export-ModuleMember -Function Select-DaysWorked
Export-ModuleMember -Function Set-PlantsAffected
Export-ModuleMember -Function Group-TimesheetData
Export-ModuleMember -Function Group-DailyTimeSegments
Export-ModuleMember -Function Measure-TimeWorked
Export-ModuleMember -Function Measure-PlantTimeAllotment
Export-ModuleMember -Function Write-TimesheetSummary