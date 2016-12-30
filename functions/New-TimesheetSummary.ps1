function New-TimesheetSummary
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript({Test-Path $_ -PathType Leaf})]
		[string]$FilePath,

		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript({(Test-Path $_ -IsValid) -and !(Test-Path $_ -PathType Container)})]
		[string]$Destination
	)

	Write-Verbose -Message ("Opening [$FilePath] to load raw report data.")

	Read-TimesheetData
	Format-TimesheetData
	Select-DaysWorked
	Set-PlantsAffected
	Group-TimesheetData
	Group-DailyTimeSegments
	Measure-TimeWorked
	Measure-PlantTimeAllotment
	Write-TimesheetSummary	

	Write-Verbose -Message ("Writing timesheet summary to [$Destination].")
}
#New-TimesheetSummary -FilePath .\Desktop\ManicTimeSearch_2016-12-05.csv -Destination .\Desktop\sample-timesheet.txt -Verbose