# Connect to your Azure account
Connect-AzAccount

# Variables for Storage Account and Blob Container
$resourceGroupName = "MyResourceGroup"
$storageAccountName = "mystorageaccount"  # Replace with your desired storage account name
$location = "East US"
$containerName = "myblobcontainer"  # Replace with your desired blob container name

# Create a new resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a new Storage Account
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -SkuName Standard_LRS -Location $location

# Create a new Blob Container in the Storage Account
$container = New-AzStorageContainer -Name $containerName -Context $storageAccount.Context -Permission Off
