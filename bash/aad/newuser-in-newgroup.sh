#!/bin/bash

#    Before running this script, make sure to:
# 1. Install Azure CLI if not already installed. Uncomment the following line to install:
#    # curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# 2. Connect to your Azure AD tenant using the following command:
#    # az login
# 3. Replace placeholders with your desired values for the new user and group.

# Variables
newUserDisplayName="John Doe"                     # Replace with the desired display name for the new user
newUserUPN="john.doe@yourtenant.onmicrosoft.com"  # Replace with the desired user principal name (UPN) for the new user
newUserPassword="YourSecurePassword"              # Replace with a strong and secure password for the new user
newGroupName="YourNewGroupName"                   # Replace with the desired name for the new group

# Create a new user in Azure AD
az ad user create --display-name $newUserDisplayName \
                  --user-principal-name $newUserUPN \
                  --password $newUserPassword \
                  --force-change-password-next-login \
                  --output none

echo "New user '$newUserDisplayName' has been created in Azure AD."

# Create a new group in Azure AD
az ad group create --display-name $newGroupName \
                   --mail-nickname $newGroupName \
                   --output none

echo "New group '$newGroupName' has been created in Azure AD."

# Variables
newUserDisplayName="John Doe"                     # Replace with the desired display name for the new user
newUserUPN="john.doe@yourtenant.onmicrosoft.com"  # Replace with the desired user principal name (UPN) for the new user
newUserPassword="YourSecurePassword"              # Replace with a strong and secure password for the new user
newGroupName="YourNewGroupName"                   # Replace with the desired name for the new group

# Create a new user in Azure AD
az ad user create --display-name $newUserDisplayName \
                  --user-principal-name $newUserUPN \
                  --password $newUserPassword \
                  --force-change-password-next-login \
                  --output none

echo "New user '$newUserDisplayName' has been created in Azure AD."

# Create a new group in Azure AD
az ad group create --display-name $newGroupName \
                   --mail-nickname $newGroupName \
                   --output none

echo "New group '$newGroupName' has been created in Azure AD."
