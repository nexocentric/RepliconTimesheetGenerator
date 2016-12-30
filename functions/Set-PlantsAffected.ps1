function Set-PlantsAffected
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )
    
    $Name = $Name.Replace(" ", "") #clear spaces
    $possiblePlantsAffected = $Name.Split(",")

	return @{
        KFI = ($possiblePlantsAffected -contains "kfi");
        KFE = ($possiblePlantsAffected -contains "kfe");
        KSP = ($possiblePlantsAffected -contains "ksp")
    }
}