# Define the variables
$resourceGroupName = "MyResourceGroup"          # Replace with the desired resource group name
$location = "northeurope"                       # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
$vmName = "MyVM"                                # Replace with your desired VM name
$vmSize = "Standard_B2s"                        # Replace with the desired VM size (e.g., Standard_B1s, Standard_D2s_v3)
$adminUsername = "adminUser"                    # Replace with the desired admin username
$adminPassword = "P@ssw0rd123"                  # Replace with your desired admin password
$imagePublisher = "MicrosoftWindowsServer"      # Publisher of the VM image (e.g., MicrosoftWindowsServer, Canonical)
$imageOffer = "WindowsServer"                   # Offer of the VM image (e.g., WindowsServer, UbuntuServer)
$imageSKU = "2019-Datacenter"                   # SKU of the VM image (e.g., 2019-Datacenter, 18.04-LTS)
$imageVersion = "latest"                        # Version of the VM image to use (e.g., latest, specific version)

# --- Resource Group ---
Write-Host "Checking if the resource group exists: $resourceGroupName"
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
    Write-Host "Resource group created: $resourceGroupName"
}
else {
    Write-Host "Resource group already exists: $resourceGroupName"
}

# --- VM Configuration ---
Write-Host "Creating VM configuration for $vmName"
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize

# Use a PSCredential object to securely store the admin credentials
$securePassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($adminUsername, $securePassword)

$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmName -Credential $credentials
$vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName $imagePublisher -Offer $imageOffer `
                                -Skus $imageSKU -Version $imageVersion
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id (Get-AzNetworkInterface -ResourceGroupName $resourceGroupName).Id

# --- Virtual Machine ---
Write-Host "Checking if the virtual machine exists: $vmName"
if (-not (Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName -ErrorAction SilentlyContinue)) {
    New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig
    Write-Host "Virtual Machine created: $vmName"
}
else {
    Write-Host "Virtual Machine already exists: $vmName"
}
