# Variables for Storage Account and Blob Container
$resourceGroupName = "MyResourceGroup"
$storageAccountName = "mystorageaccount"  # Replace with your storage account name
$containerName = "myblobcontainer"  # Replace with your blob container name

# Path to the local file you want to upload
$fileToUpload = "C:\path\to\your\file.txt"  # Replace with the path to your local file

# Connect to your Azure account
Connect-AzAccount

# Get the Storage Account context
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$ctx = $storageAccount.Context

# Upload the file to the Blob Container
$blobName = "myuploadedfile.txt"  # Replace with the desired blob name

Set-AzStorageBlobContent -Context $ctx -Container $containerName -File $fileToUpload -Blob $blobName
