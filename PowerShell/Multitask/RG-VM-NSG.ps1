
# Variables
$resourceGroupName =  "MyResourceGroup"         # Replace with the desired resource group name
$location = "northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
$vmName = "MyVM"                                # Replace with your desired VM name
$vmSize = "Standard_B2s"                        # Replace with the desired VM size (e.g., Standard_B1s, Standard_D2s_v3)
$adminUsername = "adminUser"                    # Replace with the desired admin username
$adminPassword = "P@ssw0rd123"                  # Replace with your desired admin password
$imageOffer = "WindowsServer"                   # Offer of the VM image (e.g., WindowsServer, UbuntuServer)
$imageSKU = "2019-Datacenter"                   # SKU of the VM image (e.g., 2019-Datacenter, 18.04-LTS)
$subnetName = "MySubnet"                        # Replace with your desired subnet name
$vnetName = "MyVnet"                            # Replace with your desired virtual network name
$nsgName = "MyNSG"                              # Replace with your desired network security group name


# Create Resource Group
Write-Host "Checking if the resource group exists: $resourceGroupName"
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
    Write-Host "Resource group created: $resourceGroupName"
}
else {
    Write-Host "Resource group already exists: $resourceGroupName"
}

# Create Virtual Network
Write-Host "Checking if the virtual network exists: $vnetName"
if (-not (Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName -ErrorAction SilentlyContinue)) {
    $vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName -Location $location -AddressPrefix
    Write-Host "Virtual network created: $vnetName"
}
else {
    Write-Host "Virtual network already exists: $vnetName"
}

# Create Subnet
Write-Host "Checking if the subnet exists: $subnetName"
if (-not (Get-AzVirtualNetworkSubnetConfig -VirtualNetwork (Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName) -Name $subnetName -ErrorAction SilentlyContinue)) {
    Write-Host "Creating subnet: $subnetName"
    $subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork (Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName) -AddressPrefix "10.0.2.0/24"
}

else {
    Write-Host "Subnet already exists: $subnetName"
}
    $subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork (Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName) -AddressPrefix "10.0.2.0/24"


# Create Network Security Group
Write-Host "Checking if the network security group exists: $nsgName"
if (-not (Get-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Name $nsgName -ErrorAction SilentlyContinue)) {
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $location -Name $nsgName
    Write-Host "Network security group created: $nsgName"
}
else {
    Write-Host "Network security group already exists: $nsgName"
}

# Create Network Security Group Rule
Write-Host "Checking if the network security group rule exists: $nsgName"
if (-not (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg -Name "Allow-RDP-All" -ErrorAction SilentlyContinue)) {
    $nsg = Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg -Name "Allow-RDP-All" -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
    Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg
    Write-Host "Network security group rule created: $nsgName"
}
else {
    Write-Host "Network security group rule already exists: $nsgName"
}

# Create Public IP Address
Write-Host "Checking if the public IP address exists: $vmName"
if (-not (Get-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name $vmName -ErrorAction SilentlyContinue)) {
    $publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name $vmName -Location $location -AllocationMethod Dynamic
    Write-Host "Public IP address created: $vmName"
}
else {
    Write-Host "Public IP address already exists: $vmName"
}

# Create a virtual network interface card and associate with public IP address and NSG
Write-Host "Checking if the network interface exists: $vmName"
if (-not (Get-AzNetworkInterface -ResourceGroupName $resourceGroupName -Name $vmName -ErrorAction SilentlyContinue)) {
    $nic = New-AzNetworkInterface -Name $vmName -ResourceGroupName $resourceGroupName -Location $location -SubnetId $subnet.Id -PublicIpAddressId $publicIp.Id -NetworkSecurityGroupId $nsg.Id
    Write-Host "Network interface created: $vmName"
}
else {
    Write-Host "Network interface already exists: $vmName"
}

# VM Configuration
Write-Host "Creating VM configuration for $vmName"
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmName -Credential $credentials
$vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsServer" -Offer $imageOffer `
                                -Skus $imageSKU -Version "latest"
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id (Get-AzNetworkInterface -ResourceGroupName $resourceGroupName -Name $vmName).Id

# Create Virtual Machine
Write-Host "Checking if the virtual machine exists: $vmName"
if (-not (Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName -ErrorAction SilentlyContinue)) {
    New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig
    Write-Host "Virtual Machine created: $vmName"
}
else {
    Write-Host "Virtual Machine already exists: $vmName"
}
```
