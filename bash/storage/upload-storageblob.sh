#!/bin/bash

# Before running this script, make sure to:
# 1. Install Azure CLI if not already installed. Uncomment the following line to install:
#    # curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# 2. Connect to your Azure AD tenant using the following command:
#    # az login
# 3. Replace placeholders with your desired values for the variables below.


# Define the variables
resourceGroupName="MyResourceGroup"          # Replace with the desired resource group name
storageAccountName="mystorageaccount"        # Replace with your storage account name
containerName="myblobcontainer"              # Replace with your blob container name
fileToUpload="/path/to/your/file.txt"        # Path to the local file you want to upload

# Function to upload a file to the Blob Container
function Set-AzBlobContainerContent {
    # Get the Storage Account context
    storageAccount=$(az storage account show --resource-group $resourceGroupName \
                                             --name $storageAccountName \
                                             --query "id" \
                                             --output tsv)
    ctx=$(az storage account show-connection-string --ids $storageAccount \
                                                    --query "connectionString" \
                                                    --output tsv)

    # Get the filename from the path
    blobName=$(basename $fileToUpload)

    # Upload the file to the Blob Container
    az storage blob upload --account-name $storageAccountName \
                           --account-key $(az storage account keys list --resource-group $resourceGroupName \
                                                                             --account-name $storageAccountName \
                                                                             --query "[0].value" \
                                                                             --output tsv) \
                           --container-name $containerName \
                           --name $blobName \
                           --type block \
                           --source $fileToUpload \
                           --output none
    echo "File '$fileToUpload' uploaded successfully to Blob Container '$containerName'."
}

# Call the function to upload the file to the Blob Container
Set-AzBlobContainerContent
