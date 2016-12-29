function New-TimesheetSummary
{
	Read-TimesheetData
	Format-TimesheetData
	Select-DaysWorked
	Set-PlantsAffected
	Group-TimesheetData
	Group-DailyTimeSegments
	Measure-TimeWorked
	Measure-PlantTimeAllotment
	Write-TimesheetSummary	
}