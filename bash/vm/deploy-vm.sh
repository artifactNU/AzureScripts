#!/bin/bash

# Before running this script, make sure to:
# 1. Install Azure CLI if not already installed. Uncomment the following line to install:
#    # curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# 2. Connect to your Azure AD tenant using the following command:
#    # az login
# 3. Replace placeholders with your desired values for the variables below.


# Define the variables
resourceGroupName="MyResourceGroup"          # Replace with the desired resource group name
location="northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
vmName="MyVM"                                # Replace with your desired virtual machine name
vmSize="Standard_B1s"                        # Replace with your desired virtual machine size
adminUsername="azureuser"                    # Replace with your desired admin username
adminPassword="MyPassword123"                # Replace with your desired admin password
imagePublisher="Canonical"                   # Replace with the publisher name of the image you want to use
imageOffer="UbuntuServer"                    # Replace with the offer name of the image you want to use
imageSKU="18.04-LTS"                         # Replace with the SKU of the image you want to use
imageVersion="latest"                        # Replace with the version of the image you want to use

# Function to create a new Azure Virtual Machine
function New-AzVM {
    # Create the VM configuration
    echo "Creating VM configuration for $vmName"
    vmConfig=$(az vm create --resource-group $resourceGroupName \
                            --name $vmName \
                            --location $location \
                            --size $vmSize \
                            --admin-username $adminUsername \
                            --admin-password $adminPassword \
                            --image $imagePublisher:$imageOffer:$imageSKU:$imageVersion \
                            --query "id" \
                            --output tsv)

    # Add a network interface to the VM
    az vm nic add --resource-group $resourceGroupName \
                  --vm-name $vmName \
                  --nics $(az network nic list --resource-group $resourceGroupName \
                                                --query "[0].id" \
                                                --output tsv) \
                  --output none

    echo "Virtual Machine created: $vmName"
}

# Check if the virtual machine exists
echo "Checking if the virtual machine exists: $vmName"
if [[ -z $(az vm show --resource-group $resourceGroupName \
                      --name $vmName \
                      --query "id" \
                      --output tsv 2>/dev/null) ]]; then
    # If the virtual machine doesn't exist, create it
    New-AzVM
else
    echo "Virtual Machine already exists: $vmName"
fi
