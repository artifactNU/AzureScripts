# Install Azure AD PowerShell module if not already installed
# Install-Module -Name AzureAD

# Connect to your Azure AD tenant
# Connect-AzureAD

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
