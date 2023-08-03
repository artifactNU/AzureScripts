# Install Azure AD PowerShell module if not already installed
# Install-Module -Name AzureAD

# Connect to your Azure AD tenant
# Connect-AzureAD

# Define the resource group and VM names
$resourceGroupName = "MyResourceGroup"
$virtualMachineName = "MyVirtualMachine"

# Set the Azure region where the backup vault will be created
$location = "East US"

# Set the backup policy name and retention period in days
$backupPolicyName = "DailyBackupPolicy"
$retentionDays = 30

# Set the backup vault name and create the vault
$backupVaultName = "MyBackupVault"
New-AzRecoveryServicesVault -ResourceGroupName $resourceGroupName -Name $backupVaultName -Location $location

# Create a backup policy for the virtual machine
New-AzRecoveryServicesBackupProtectionPolicy -Name $backupPolicyName -ResourceGroupName $resourceGroupName -VaultName $backupVaultName -WorkloadType AzureVM -RetentionDaily $retentionDays

# Get the virtual machine ID
$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $virtualMachineName
$vmID = $vm.Id

# Enable backup protection for the virtual machine using the backup policy
Set-AzRecoveryServicesBackupProtection -Policy $backupPolicyName -ResourceGroupName $resourceGroupName -VaultName $backupVaultName -WorkloadType AzureVM -Name $virtualMachineName

# Perform a manual backup of the virtual machine
Backup-AzRecoveryServicesBackupItem -ResourceGroupName $resourceGroupName -VaultName $backupVaultName -WorkloadType AzureVM -Name $virtualMachineName

# Optionally, you can restore the virtual machine using the backup data
# Restore-AzRecoveryServicesBackupItem -ResourceGroupName $resourceGroupName -VaultName $backupVaultName -ItemName $virtualMachineName -StorageAccountId $vmID -RestoreToStagingStorageAccount
