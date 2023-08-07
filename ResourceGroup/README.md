Azure-Resource-Group is a PowerShell script designed to facilitate the creation of an Azure Resource Group. A Resource Group is a fundamental building block in Azure that allows you to organize and manage related resources within a single container. This script automates the process of creating a new Resource Group in your Azure subscription.

The script will perform the following steps:

Define the desired resource group name and Azure region (location) within the script. Modify the variables $resourceGroupName and $location to match your preferences.
Check if a resource group with the same name already exists. If not, it will create the new Resource Group with the specified name and location.
Modify Resource Group Information: Within the script, you can modify the following variables to customize the Resource Group's properties:

$resourceGroupName: Replace with your desired name for the new Resource Group.
$location: Replace with your desired Azure region (e.g., "East US", "West Europe", etc.).
