# Install and import the Az module (if not already installed)
if (-not (Get-Module -Name Az -ErrorAction SilentlyContinue)) {
    Install-Module -Name Az -Force
}
Import-Module Az -Force

# Connect to your Azure account (you will be prompted to log in if not already authenticated)
Connect-AzAccount

# Define the resource group name and location
$resourceGroupName = "MyResourceGroup" # Replace with your desired resource group name
$location = "East US" # Replace with your desired Azure region

# Check if the resource group already exists, and create it if it doesn't
$existingResourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $existingResourceGroup) {
    # Create the new Resource Group
    New-AzResourceGroup -Name $resourceGroupName -Location $location
    Write-Host "Resource group '$resourceGroupName' created successfully in '$location'."
} else {
    Write-Host "Resource group '$resourceGroupName' already exists."
}
