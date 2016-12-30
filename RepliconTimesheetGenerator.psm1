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