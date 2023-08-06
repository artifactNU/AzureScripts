
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

# Main script starts here
try {
    # Variables for Storage Account and Blob Container
    $resourceGroupName = "MyResourceGroup"       # Replace with the desired resource group name
    $storageAccountName = "mystorageaccount"     # Replace with your desired storage account name
    $location = "swedencentral"                  # Replace with your desired Azure region
    $containerName = "myblobcontainer"           # Replace with your desired blob container name

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
}
catch {
    Write-Host "An error occurred: $_"
}
