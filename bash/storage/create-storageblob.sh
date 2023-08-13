#!/bin/bash

# Define the variables
resourceGroupName="MyResourceGroup"          # Replace with the desired resource group name
storageAccountName="mystorageaccount"        # Replace with your desired storage account name
location="northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
containerName="myblobcontainer"              # Replace with your desired blob container name
fileToUpload="/path/to/your/file.txt"        # Path to the local file you want to upload

# Function to create a new Azure Storage Account and Blob Container
function New-AzStorageAccountWithContainer {
    # Create the new Storage Account
    storageAccount=$(az storage account create --resource-group $resourceGroupName \
                                               --name $storageAccountName \
                                               --location $location \
                                               --sku Standard_LRS \
                                               --query "id" \
                                               --output tsv)

    # Create a new Blob Container in the Storage Account
    az storage container create --name $containerName \
                                --account-name $storageAccountName \
                                --account-key $(az storage account keys list --resource-group $resourceGroupName \
                                                                                  --account-name $storageAccountName \
                                                                                  --query "[0].value" \
                                                                                  --output tsv) \
                                --output none
}

# Call the function to create the new Storage Account and Blob Container
New-AzStorageAccountWithContainer

# Upload the file to the Blob Container
az storage blob upload --account-name $storageAccountName \
                       --account-key $(az storage account keys list --resource-group $resourceGroupName \
                                                                         --account-name $storageAccountName \
                                                                         --query "[0].value" \
                                                                         --output tsv) \
                       --container-name $containerName \
                       --name $(basename $fileToUpload) \
                       --type block \
                       --source $fileToUpload \
                       --output none