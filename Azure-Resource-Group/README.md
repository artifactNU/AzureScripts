Azure Resource Group Creation Script
The Azure Resource Group Creation Script is a PowerShell script designed to facilitate the creation of an Azure Resource Group. A Resource Group is a fundamental building block in Azure that allows you to organize and manage related resources within a single container. This script automates the process of creating a new Resource Group in your Azure subscription.

Prerequisites
Before using this script, ensure you have the following:

Azure PowerShell Module: The script requires the Azure PowerShell module to interact with your Azure account and resources. If you don't have the module installed, the script will automatically install it for you.

Azure Account: You need an active Azure account with the necessary permissions to create Resource Groups. When executing the script, you will be prompted to log in to your Azure account.

How to Use
Download the Script: Download the "create_resource_group.ps1" script and save it to your local machine.

Execute the Script: Open a PowerShell session, navigate to the directory where the script is located, and run the script using the following command:
.\create_resource_group.ps1


The script will perform the following steps:

Check if the Azure PowerShell module is installed and, if not, automatically install it.
Prompt you to log in to your Azure account to establish a connection.
Define the desired resource group name and Azure region (location) within the script. Modify the variables $resourceGroupName and $location to match your preferences.
Check if a resource group with the same name already exists. If not, it will create the new Resource Group with the specified name and location.
Modify Resource Group Information: Within the script, you can modify the following variables to customize the Resource Group's properties:

$resourceGroupName: Replace with your desired name for the new Resource Group.
$location: Replace with your desired Azure region (e.g., "East US", "West Europe", etc.).

The script includes several enhancements to ensure better user experience and reliability:

Checks for the presence of the Azure PowerShell module and installs it if required.
Prompts for Azure account login, ensuring secure and authorized access.
Verifies if the Resource Group already exists before creating it, preventing accidental duplicates.
