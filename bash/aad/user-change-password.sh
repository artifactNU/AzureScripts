#!/bin/bash

# Before running this script, make sure to:
# 1. Install the Azure CLI using the following command:
#    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# 2. Log in to your Azure account using the following command:
#    az login
# 3. Replace placeholders with actual values for the user and new password.

# Variables
userUPN="john.doe@yourtenant.onmicrosoft.com"  # Replace with the user principal name (UPN) of the user whose password you want to update
newPassword="YourNewPassword"                  # Replace with the new password for the user

# Get the user from Azure AD
user=$(az ad user show --id $userUPN)

# Update the user's password
az ad user update --id $userUPN --password $newPassword

echo "Password for user '$user.displayName' has been updated."