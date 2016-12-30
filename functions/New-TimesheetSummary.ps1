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

	$previousVerbosity = $PSDefaultParameterValues["*:Verbose"]
	$PSDefaultParameterValues["*:Verbose"] = $PSBoundParameters["Verbose"]
	Write-Verbose -Message ("Opening [$FilePath] to load raw report data.")

	$rawData = Read-TimesheetData -Path $FilePath
	$formattedData = Format-TimesheetData -InputObject $rawData

	Select-DaysWorked
	Group-TimesheetData
	Group-DailyTimeSegments
	Measure-TimeWorked
	Measure-PlantTimeAllotment
	Write-TimesheetSummary	

	Write-Verbose -Message ("Writing timesheet summary to [$Destination].")
	$PSDefaultParameterValues["*:Verbose"] = $previousVerbosity
}
#New-TimesheetSummary -FilePath .\Desktop\ManicTimeSearch_2016-12-05.csv -Destination .\Desktop\sample-timesheet.txt -Verbose