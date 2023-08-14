#    Before running this script, make sure to:
# 1. Install the Azure PowerShell module using the following PowerShell command:
#    Install-Module -Name Az
# 2. Connect to your Azure account using the following PowerShell command:
#    Connect-AzAccount
# 3. Replace placeholders with your desired values for resource group name and location.

# Define the variables
$resourceGroupName = "MyResourceGroup"          # Replace with your desired resource group name
$location = "northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)

# Validate the location
$validLocations = Get-AzLocation | Select-Object -ExpandProperty Location
if (-not $validLocations.Contains($location)) {
    Write-Error "Invalid location specified. Please enter a valid Azure region."
    return
}

# Check if the resource group already exists, and create it if it doesn't
$existingResourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $existingResourceGroup) {
    # Create the new Resource Group
    New-AzResourceGroup -Name $resourceGroupName -Location $location
    Write-Host "Resource group '$resourceGroupName' created successfully in '$location'."
} else {
    Write-Host "Resource group '$resourceGroupName' already exists."
}
