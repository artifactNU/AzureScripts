Getting Started Guide
Welcome to the GitHub repository for PowerShell scripts tailored for Microsoft Azure! This guide will walk you through the basics of using and writing PowerShell scripts to interact with Azure services.


----------------------------------------------------------------

Prerequisites
To use PowerShell scripts for Azure, you need the following:

Azure Account: You must have an active Azure account with the necessary permissions to access and manage Azure resources.

Azure PowerShell Module: Ensure you have the Azure PowerShell module installed on your machine. You can install it using the following command:
Install-Module -Name Az -Force

Installing Azure PowerShell Module
If you haven't already installed the Azure PowerShell module, execute the provided command above. This will download and install the module from the PowerShell Gallery.

Connecting to Azure
Before running any scripts, you must connect to your Azure account. Execute the following command to sign in:
Connect-AzAccount

This will prompt you to log in with your Azure credentials and establish a connection to your Azure subscription.

----------------------------------------------------------------

Using the Existing PowerShell Scripts
Executing a Script
In this repository, you'll find a collection of pre-existing PowerShell scripts. To use them:

Clone or download this repository to your local machine.

Open a PowerShell session and navigate to the folder containing the scripts.

To execute a script, simply run:
.\script-name.ps1

Customizing the Script
Each script is well-documented and contains variables that you can modify to tailor the script to your needs. Before executing a script, open it in a text editor and review the comments to understand its functionality and required inputs.

