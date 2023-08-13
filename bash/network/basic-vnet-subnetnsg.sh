#!/bin/bash

# Variables (You can change these values as needed)
resourceGroupName="YourResourceGroupName"  # Replace with your desired resource group name
location="northeurope"                     # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
vnetName="YourVirtualNetworkName"          # Replace with your desired virtual network name
subnetName="YourSubnetName"                # Replace with your desired subnet name
nsgName="YourNSGName"                      # Replace with your desired Network Security Group (NSG) name

# Create a new Azure Virtual Network
az network vnet create --name $vnetName \
                       --resource-group $resourceGroupName \
                       --location $location \
                       --address-prefixes "10.0.0.0/16" \
                       --output none

# Create a new subnet in the virtual network
az network vnet subnet create --name $subnetName \
                              --vnet-name $vnetName \
                              --resource-group $resourceGroupName \
                              --address-prefixes "10.0.1.0/24" \
                              --output none

# Create a new Network Security Group (NSG)
az network nsg create --name $nsgName \
                      --resource-group $resourceGroupName \
                      --location $location \
                      --output none

# Allow RDP (Remote Desktop) inbound traffic to the subnet (example rule)
az network nsg rule create --name "Allow-RDP" \
                           --nsg-name $nsgName \
                           --resource-group $resourceGroupName \
                           --priority 100 \
                           --protocol Tcp \
                           --direction Inbound \
                           --source-address-prefixes "Internet" \
                           --source-port-ranges "*" \
                           --destination-address-prefixes "VirtualNetwork" \
                           --destination-port-ranges 3389 \
                           --access Allow \
                           --output none

# Associate the NSG with the subnet
az network vnet subnet update --name $subnetName \
                              --vnet-name $vnetName \
                              --resource-group $resourceGroupName \
                              --network-security-group $nsgName \
                              --output none

echo "Azure Virtual Network, Subnet, and Network Security Group have been created and configured successfully."