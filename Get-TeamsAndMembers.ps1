#requires -version 4
<#
.SYNOPSIS
  Retreive all Microsoft Teams teams and show you all their memebers.

.DESCRIPTION
  This script requires Microsoft Teams module v 0.9.6. Newer versions have been stripped of from some required commands
  
  Install it by running the below command in a Powershell consol (Run as Administrator)
  Install-Module -Name MicrosoftTeams -RequiredVersion 0.9.6

.PARAMETER TenantId
  This is your AzreAD Tenant ID. To get it, Go to your Azure AD Administration plateform, then Azure Active Directory -> Properties and copy the value of Directory ID

.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         FingersOnFire
  Creation Date:  2020-04-16
  Purpose/Change: Initial script development

.EXAMPLE
  Basic Example
  
  Get-TeamsAndMembers.ps1 -TenantId ******
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

Param (
  [Parameter(Mandatory=$True)][string]$TenantId
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#Import Modules & Snap-ins
Import-Module -Name MicrosoftTeams

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Any Global Declarations go here

#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#

Function <FunctionName> {
  Param ()

  Begin {
    Write-Host '<description of what is going on>...'
  }

  Process {
    Try {
      <code goes here>
    }

    Catch {
      Write-Host -BackgroundColor Red "Error: $($_.Exception)"
      Break
    }
  }

  End {
    If ($?) {
      Write-Host 'Completed Successfully.'
      Write-Host ' '
    }
  }
}

#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------


$connectionstatus = Connect-MicrosoftTeams -TenantId $TenantId

if($connectionstatus -eq $null){
    Write-Host "Connection Failed. Exiting..."
    exit
}

$teams = Get-Team

foreach($team in $teams){

    Write-Host $team.DisplayName
    Get-TeamUser -GroupId $team.GroupId
    Write-Host
}