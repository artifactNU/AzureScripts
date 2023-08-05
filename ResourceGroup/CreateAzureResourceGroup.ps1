
# Define the resource group name and location
$resourceGroupName = "MyResourceGroup" # Replace with your desired resource group name
$location = "swedencentral" # Replace with your desired Azure region

# Check if the resource group already exists, and create it if it doesn't
$existingResourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $existingResourceGroup) {
    # Create the new Resource Group
    New-AzResourceGroup -Name $resourceGroupName -Location $location
    Write-Host "Resource group '$resourceGroupName' created successfully in '$location'."
} else {
    Write-Host "Resource group '$resourceGroupName' already exists."
}
