# Before running this script, make sure to:
# 1. Install the AzureAD module using the following PowerShell command:
#    Install-Module -Name AzureAD
# 2. Connect to your Azure AD tenant using the following PowerShell command:
#    Connect-AzureAD
# 3. Replace placeholders with actual values for the new user and group.

# Variables
$newUserDisplayName = "John Doe"                     # Replace with the desired display name for the new user
$newUserUPN = "john.doe@yourtenant.onmicrosoft.com"  # Replace with the desired user principal name (UPN) for the new user
$newUserPassword = "YourSecurePassword"              # Replace with a strong and secure password for the new user
$newGroupName = "YourNewGroupName"                   # Replace with the desired name for the new group

# Create a new user in Azure AD
$newUser = New-AzureADUser -DisplayName $newUserDisplayName `
                           -UserPrincipalName $newUserUPN `
                           -Password $newUserPassword `
                           -AccountEnabled $true

Write-Host "New user '$newUserDisplayName' has been created in Azure AD."

# Create a new group in Azure AD
$newGroup = New-AzureADGroup -DisplayName $newGroupName `
                             -MailEnabled $false `
                             -SecurityEnabled $true

Write-Host "New group '$newGroupName' has been created in Azure AD."

# Add the user to the group
Add-AzureADGroupMember -ObjectId $newGroup.ObjectId `
                       -RefObjectId $newUser.ObjectId

Write-Host "User '$newUserDisplayName' has been added to group '$newGroupName'."
