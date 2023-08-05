
# Variables for Storage Account and Blob Container
$resourceGroupName = "MyResourceGroup"        # Replace with the desired resource group name
$storageAccountName = "mystorageaccount"      # Replace with your storage account name
$containerName = "myblobcontainer"            # Replace with your blob container name

# Path to the local file you want to upload
$fileToUpload = "C:\path\to\your\file.txt"     # Replace with the path to your local file

# Connect to your Azure account
Connect-AzAccount

# Function to upload a file to the Blob Container
function Set-AzBlobContainerContent {
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

        # Upload the file to the Blob Container
        Set-AzStorageBlobContent -Context $ctx -Container $ContainerName -File $FilePath -Blob $blobName -Force
        Write-Host "File '$FilePath' uploaded successfully to Blob Container '$ContainerName'."
    }
    catch {
        Write-Host "An error occurred while uploading the file: $_"
    }
}

# Main script starts here

try {
    # Call the function to upload the file to the Blob Container
    Set-AzBlobContainerContent -ResourceGroupName $resourceGroupName `
                               -StorageAccountName $storageAccountName `
                               -ContainerName $containerName `
                               -FilePath $fileToUpload
}
catch {
    Write-Host "An error occurred: $_"
}
