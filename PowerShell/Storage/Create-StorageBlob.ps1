#    Before running this script, make sure to:
# 1. Install the Azure PowerShell module using the following PowerShell command:
#    Install-Module -Name Az
# 2. Connect to your Azure account using the following PowerShell command:
#    Connect-AzAccount
# 3. Replace placeholders with your desired values for resource group, storage account, location, container, and file path.

# Define the variables
$resourceGroupName = "MyResourceGroup"          # Replace with the desired resource group name
$storageAccountName = "mystorageaccount"        # Replace with your desired storage account name
$location = "northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
$containerName = "myblobcontainer"              # Replace with your desired blob container name
$fileToUpload = "C:\path\to\your\file.txt"      # Path to the local file you want to upload

# Function to create a new Azure Storage Account and Blob Container
function New-AzStorageAccountWithContainer {
    param (
        [string]$ResourceGroupName,
        [string]$StorageAccountName,
        [string]$Location,
        [string]$ContainerName
    )

    try {
        # Create the new Storage Account
        $storageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName `
                                              -Name $StorageAccountName `
                                              -Location $Location `
                                              -SkuName "Standard_LRS"  # Replace with the desired SKU (e.g., Standard_LRS, Standard_GRS, etc.)

        # Create a new Blob Container in the Storage Account
        New-AzStorageContainer -Name $ContainerName `
                               -Context $storageAccount.Context `
                               -Permission Off

        Write-Host "Storage Account '$StorageAccountName' created successfully in '$Location'."
        Write-Host "Blob Container '$ContainerName' created successfully in Storage Account '$StorageAccountName'."
    }
    catch {
        Write-Host "An error occurred while creating the resources: $_"
    }
}

# Function to send a file to the Blob Container
function Send-FileToBlobContainer {
    param (
        [string]$ResourceGroupName,
        [string]$StorageAccountName,
        [string]$ContainerName,
        [string]$FilePath
    )

    try {
        # Get the Storage Account context
        $storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
        $ctx = $storageAccount.Context

        # Get the filename from the path
        $blobName = [System.IO.Path]::GetFileName($FilePath)

        # Send the file to the Blob Container
        Set-AzStorageBlobContent -Context $ctx -Container $ContainerName -File $FilePath -Blob $blobName -Force
        Write-Host "File '$FilePath' sent successfully to Blob Container '$ContainerName'."
    }
    catch {
        Write-Host "An error occurred while sending the file: $_"
    }
}

# Main script starts here

try {
    # Check if the resource group exists, and create it if it doesn't
    if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
        New-AzResourceGroup -Name $resourceGroupName -Location $location
        Write-Host "Resource group '$resourceGroupName' created successfully in '$location'."
    }
    else {
        Write-Host "Resource group '$resourceGroupName' already exists."
    }

    # Create the new Storage Account and Blob Container
    New-AzStorageAccountWithContainer -ResourceGroupName $resourceGroupName `
                                      -StorageAccountName $storageAccountName `
                                      -Location $location `
                                      -ContainerName $containerName

    # Send the file to the Blob Container
    Send-FileToBlobContainer -ResourceGroupName $resourceGroupName `
                             -StorageAccountName $storageAccountName `
                             -ContainerName $containerName `
                             -FilePath $fileToUpload
}
catch {
    Write-Host "An error occurred: $_"
}
