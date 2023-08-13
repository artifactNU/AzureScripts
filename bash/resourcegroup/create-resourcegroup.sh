#!/bin/bash

# Define the variables
resourceGroupName="MyResourceGroup"  # Replace with your desired resource group name
location="northeurope"               # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)

# Validate the location
validLocations=$(az account list-locations --query "[].name" -o tsv)
if [[ ! $validLocations =~ (^|[[:space:]])$location($|[[:space:]]) ]]; then
    echo "Invalid location specified. Please enter a valid Azure region."
    exit 1
fi

# Check if the resource group already exists, and create it if it doesn't
existingResourceGroup=$(az group show --name $resourceGroupName --query id -o tsv 2>/dev/null)
if [[ -z $existingResourceGroup ]]; then
    # Create the new Resource Group
    az group create --name $resourceGroupName --location $location
    echo "Resource group '$resourceGroupName' created successfully in '$location'."
else
    echo "Resource group '$resourceGroupName' already exists."
fi