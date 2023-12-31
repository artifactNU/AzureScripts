#    Before running this script, make sure to:
# 1. Install the Azure PowerShell module using the following PowerShell command:
#    Install-Module -Name Az
# 2. Connect to your Azure account using the following PowerShell command:
#    Connect-AzAccount
# 3. Replace placeholders with your desired values for resource group, location, virtual network, subnet, and NSG.

# Variables (You can change these values as needed)
$resourceGroupName = "YourResourceGroupName"    # Replace with your desired resource group name
$location = "northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
$vnetName = "YourVirtualNetworkName"            # Replace with your desired virtual network name
$subnetName = "YourSubnetName"                  # Replace with your desired subnet name
$nsgName = "YourNSGName"                        # Replace with your desired Network Security Group (NSG) name

# Create a new Azure Virtual Network
$vnet = New-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName -Location $location -AddressPrefix "10.0.0.0/16"

# Create a new subnet in the virtual network
Add-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet -AddressPrefix "10.0.1.0/24" | Set-AzVirtualNetwork

# Create a new Network Security Group (NSG)
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $location -Name $nsgName

# Allow RDP (Remote Desktop) inbound traffic to the subnet (example rule)
$nsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow RDP to subnet" -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "VirtualNetwork" -DestinationPortRange 3389 -Access Allow
$nsg | Set-AzNetworkSecurityGroup

# Associate the NSG with the subnet
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -AddressPrefix "10.0.1.0/24" -NetworkSecurityGroup $nsg | Set-AzVirtualNetwork

Write-Host "Azure Virtual Network, Subnet, and Network Security Group have been created and configured successfully."
