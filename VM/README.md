### Azure-Deploy-VM
This script allows you to deploy an Azure Virtual Machine with customizable configurations, such as VM size, OS image, network settings, and administrative credentials.

### Script Explanation
Customize the script by replacing the placeholder values.

The script performs the following actions:
1. The script checks if the specified resource group already exists. If not, it creates the resource group in the provided Azure region.
2. Creates the VM configuration with the specified settings, including VM name, size, Windows operating system, and admin credentials.
3. Retrieves an existing network interface or creates a new one in the specified resource group.
4. Checks if the specified VM already exists in the resource group. If not, it creates the VM with the previously defined configuration.

Create the resource group (if it doesn't exist) using New-AzResourceGroup.
Configure the VM using New-AzVMConfig, including OS settings, VM size, and network interface.
Deploy the VM using New-AzVM.

-----------------------------------------------------------------

### Azure-VM-Backup
This script allows you to set up automated backups for an Azure Virtual Machine (VM) and perform manual backups using Azure Backup services. Additionally, you have the option to restore the VM to a previous state using the backup data if required.

### Script Explanation
Replace the placeholder values with your desired configurations.

The script performs the following actions:
1. The script sets up the Azure Recovery Services Vault by creating a new backup vault in the specified resource group and location.
2. Creates a backup policy for the virtual machine with the specified retention period.
3. Enables backup protection for the specified virtual machine using the created backup policy.
4. Performs a manual backup of the virtual machine using the created backup policy and vault.
5. Includes a commented out command to restore the virtual machine using the backup data. You can uncomment and modify this section if you wish to perform a restoration.

Create an Azure Recovery Services Vault using New-AzRecoveryServicesVault.
Create a backup policy for the VM using New-AzRecoveryServicesBackupProtectionPolicy.
Enable backup protection for the VM using Set-AzRecoveryServicesBackupProtection.
Perform a manual backup of the VM using Backup-AzRecoveryServicesBackupItem.
Note: The script also includes optional restore functionality (Restore-AzRecoveryServicesBackupItem), which can be uncommented if you need to perform VM restoration from the backup data.
