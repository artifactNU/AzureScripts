#!/bin/bash

# Define the variables
resourceGroupName="MyResourceGroup"          # Replace with your resource group name
virtualMachineName="MyVirtualMachine"        # Replace with your virtual machine name
location="northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
backupPolicyName="DailyBackupPolicy"         # Replace with your desired backup policy name
retentionDays=30                             # Replace with your desired retention period in days
backupVaultName="MyBackupVault"              # Replace with your desired backup vault name

# Function to create a new Azure Recovery Services Vault
function New-AzRecoveryServicesVault {
    # Create the Recovery Services Vault
    echo "Creating Recovery Services Vault '$backupVaultName'"
    az backup vault create --name $backupVaultName \
                           --resource-group $resourceGroupName \
                           --location $location \
                           --output none
    echo "Recovery Services Vault '$backupVaultName' created successfully in '$location'."
}

# Function to create a backup protection policy for the virtual machine
function New-AzBackupProtectionPolicy {
    # Create the backup protection policy
    echo "Creating backup protection policy '$backupPolicyName'"
    az backup policy set --name $backupPolicyName \
                         --resource-group $resourceGroupName \
                         --vault-name $backupVaultName \
                         --backup-management-type AzureIaasVM \
                         --item-name $virtualMachineName \
                         --retention-days $retentionDays \
                         --output none
    echo "Backup protection policy '$backupPolicyName' created successfully."
}

# Check if the Recovery Services Vault exists
echo "Checking if the Recovery Services Vault exists: $backupVaultName"
if [[ -z $(az backup vault show --name $backupVaultName \
                                --resource-group $resourceGroupName \
                                --query "id" \
                                --output tsv 2>/dev/null) ]]; then
    # If the Recovery Services Vault doesn't exist, create it
    New-AzRecoveryServicesVault
else
    echo "Recovery Services Vault already exists: $backupVaultName"
fi

# Check if the backup protection policy exists
echo "Checking if the backup protection policy exists: $backupPolicyName"
if [[ -z $(az backup policy show --name $backupPolicyName \
                                 --resource-group $resourceGroupName \
                                 --vault-name $backupVaultName \
                                 --query "id" \
                                 --output tsv 2>/dev/null) ]]; then
    # If the backup protection policy doesn't exist, create it
    New-AzBackupProtectionPolicy
else
    echo "Backup protection policy already exists: $backupPolicyName"
fi