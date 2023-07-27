# Connect to your Azure account
Connect-AzAccount

# Variables for Storage Account and Blob Container
$resourceGroupName = "MyResourceGroup"       # Replace with the desired resource group name
$storageAccountName = "mystorageaccount"     # Replace with your desired storage account name
$location = "East US"                        # Replace with your desired Azure region
$containerName = "myblobcontainer"           # Replace with your desired blob container name

# Create the new Storage Account
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
                                      -Name $storageAccountName `
                                      -Location $location `
                                      -SkuName "Standard_LRS"  # Replace with the desired SKU (e.g., Standard_LRS, Standard_GRS, etc.)

# Create a new Blob Container in the Storage Account
$container = New-AzStorageContainer -Name $containerName `
                                    -Context $storageAccount.Context `
                                    -Permission Off

Write-Host "Storage Account '$storageAccountName' created successfully in '$location'."
Write-Host "Blob Container '$containerName' created successfully in Storage Account '$storageAccountName'."
