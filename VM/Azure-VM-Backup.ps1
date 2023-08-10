# Define the variables
$resourceGroupName = "MyResourceGroup"          # Replace with your resource group name
$virtualMachineName = "MyVirtualMachine"        # Replace with your virtual machine name
$location = "northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
$backupPolicyName = "DailyBackupPolicy"         # Replace with your desired backup policy name
$retentionDays = 30                             # Replace with your desired retention period in days
$backupVaultName = "MyBackupVault"              # Replace with your desired backup vault name

# Create a new Azure Recovery Services Vault
function New-AzRecoveryServicesVault {
    param (
        [string]$ResourceGroupName,
        [string]$VaultName,
        [string]$Location
    )

    try {
        New-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $VaultName -Location $Location
        Write-Host "Recovery Services Vault '$VaultName' created successfully in '$Location'."
    }
    catch {
        Write-Host "An error occurred while creating the Recovery Services Vault: $_"
    }
}

# Create a backup protection policy for the virtual machine
function New-AzBackupProtectionPolicy {
    param (
        [string]$PolicyName,
        [string]$ResourceGroupName,
        [string]$VaultName,
        [int]$RetentionDays
    )

    try {
        New-AzRecoveryServicesBackupProtectionPolicy -Name $PolicyName -ResourceGroupName $ResourceGroupName `
            -VaultName $VaultName -WorkloadType AzureVM -RetentionDaily $RetentionDays
        Write-Host "Backup policy '$PolicyName' created successfully."
    }
    catch {
        Write-Host "An error occurred while creating the backup policy: $_"
    }
}

# Enable backup protection for the virtual machine using the backup policy
function Enable-BackupProtection {
    param (
        [string]$PolicyName,
        [string]$ResourceGroupName,
        [string]$VaultName,
        [string]$VirtualMachineName
    )

    try {
        Set-AzRecoveryServicesBackupProtection -Policy $PolicyName -ResourceGroupName $ResourceGroupName `
            -VaultName $VaultName -WorkloadType AzureVM -Name $VirtualMachineName
        Write-Host "Backup protection enabled for virtual machine '$VirtualMachineName' using policy '$PolicyName'."
    }
    catch {
        Write-Host "An error occurred while enabling backup protection: $_"
    }
}

# Start a manual backup of the virtual machine
function Start-AzManualBackup {
    param (
        [string]$ResourceGroupName,
        [string]$VaultName,
        [string]$VirtualMachineName
    )

    try {
        Backup-AzRecoveryServicesBackupItem -ResourceGroupName $ResourceGroupName `
            -VaultName $VaultName -WorkloadType AzureVM -Name $VirtualMachineName
        Write-Host "Manual backup of virtual machine '$VirtualMachineName' started successfully."
    }
    catch {
        Write-Host "An error occurred while starting manual backup: $_"
    }
}

# Main script starts here

try {
    # Create the Recovery Services Vault
    New-AzRecoveryServicesVault -ResourceGroupName $resourceGroupName -VaultName $backupVaultName -Location $location

    # Create the backup policy
    New-AzBackupProtectionPolicy -PolicyName $backupPolicyName -ResourceGroupName $resourceGroupName `
        -VaultName $backupVaultName -RetentionDays $retentionDays

    # Enable backup protection for the virtual machine
    Enable-BackupProtection -PolicyName $backupPolicyName -ResourceGroupName $resourceGroupName `
        -VaultName $backupVaultName -VirtualMachineName $virtualMachineName

    # Start a manual backup of the virtual machine
    Start-AzManualBackup -ResourceGroupName $resourceGroupName -VaultName $backupVaultName `
        -VirtualMachineName $virtualMachineName
}
catch {
    Write-Host "An error occurred: $_"
}
