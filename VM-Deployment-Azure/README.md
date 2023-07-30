1. Azure Virtual Machine Deployment Script (vm_deployment.ps1)
This script allows you to deploy an Azure Virtual Machine with customizable configurations, such as VM size, OS image, network settings, and administrative credentials.

Instructions:
Ensure you have the Azure PowerShell module installed (Install-Module Az) and the required permissions for VM creation.

Customize the script by replacing the placeholder values:

$resourceGroupName: Name of the target resource group (if it doesn't exist, it will be created).
$location: Azure region where the VM will be deployed.
$vmName: Desired name for the new VM.
$vmSize: Size of the VM (e.g., "Standard_B2s").
$adminUsername: Desired administrator username.
$adminPassword: Password for the administrator account.
$imagePublisher, $imageOffer, $imageSKU, $imageVersion: Details of the OS image to be used for the VM.
Run the script using PowerShell to execute the following steps:

Connect to your Azure account using Connect-AzAccount.
Create the resource group (if it doesn't exist) using New-AzResourceGroup.
Configure the VM using New-AzVMConfig, including OS settings, VM size, and network interface.
Deploy the VM using New-AzVM.
Note: The script performs a check to ensure the resource group and VM don't already exist before creating them, reducing the risk of accidental duplications.

2. Automated Backup and Restore Script (backup_restore.ps1)
This script allows you to set up automated backups for an Azure Virtual Machine (VM) and perform manual backups using Azure Backup services. Additionally, you have the option to restore the VM to a previous state using the backup data if required.

Instructions:
Ensure you have the Azure PowerShell module installed (Install-Module Az) and have the necessary permissions to manage backups.

Replace the placeholder values with your desired configurations:

$resourceGroupName: Name of the target resource group.
$virtualMachineName: Name of the target VM to be backed up.
$location: Azure region where the backup vault will be created.
$backupPolicyName: Desired name for the backup policy.
$retentionDays: Number of days to retain the backup data.
Run the script using PowerShell to execute the following steps:

Connect to your Azure account using Connect-AzAccount.
Create an Azure Recovery Services Vault using New-AzRecoveryServicesVault.
Create a backup policy for the VM using New-AzRecoveryServicesBackupProtectionPolicy.
Enable backup protection for the VM using Set-AzRecoveryServicesBackupProtection.
Perform a manual backup of the VM using Backup-AzRecoveryServicesBackupItem.
Note: The script also includes optional restore functionality (Restore-AzRecoveryServicesBackupItem), which can be uncommented if you need to perform VM restoration from the backup data.
