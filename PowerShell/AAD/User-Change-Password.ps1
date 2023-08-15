# Before running this script, make sure to:
# 1. Install the AzureAD module using the following PowerShell command:
#    Install-Module -Name AzureAD
# 2. Connect to your Azure AD tenant using the following PowerShell command:
#    Connect-AzureAD
# 3. Replace placeholders with actual values for the user and new password.

# Variables
$userUPN = "john.doe@yourtenant.onmicrosoft.com"  # Replace with the user principal name (UPN) of the user whose password you want to update
$newPassword = "YourNewPassword"                  # Replace with the new password for the user

# Get the user from Azure AD
$user = Get-AzureADUser -ObjectId (Get-AzureADUser -Filter "UserPrincipalName eq '$userUPN'").ObjectId

# Update the user's password
Set-AzureADUserPassword -ObjectId $user.ObjectId `
                        -Password $newPassword `
                        -ForceChangePasswordNextLogin $false

Write-Host "Password for user '$user.DisplayName' has been updated."