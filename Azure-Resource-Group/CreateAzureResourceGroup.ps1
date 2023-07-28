# Install and import the Az module (if not already installed)
Install-Module -Name Az -Force
Import-Module Az

# Connect to your Azure account (you will be prompted to log in)
Connect-AzAccount

# Define the resource group name and location
$resourceGroupName = "MyResourceGroup" # Replace with your desired resource group name
$location = "East US" # Replace with your desired Azure region

# Create the new Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location
