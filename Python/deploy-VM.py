# Before running this script, make sure to:
# 1. Install the Azure PowerShell module using the following PowerShell command:
#    Install-Module -Name Az
# 2. Install the required Azure SDK packages using the following command:
#    pip install azure-identity azure-mgmt-compute azure-mgmt-resource
# 3. Replace placeholders like "<Azure Subscription ID>" and other variables with your actual values.
# 4. Ensure you have the necessary permissions in your Azure subscription to create resources.


from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from azure.mgmt.resource import ResourceManagementClient

# Define the variables
resource_group_name = "MyResourceGroup"     # Replace with your resource group name
location = "northeurope"                    # Replace with your desired Azure region ('westus', 'eastasia', 'northeurope' etc.)
vm_name = "MyVM"                            # Replace with your virtual machine name                            
vm_size = "Standard_B2s"                    # Replace with your desired VM size ('Standard_B2s', 'Standard_D2s_v3' etc.)
admin_username = "adminUser"                # Replace with your desired admin username
admin_password = "P@ssw0rd123"              # Replace with your desired admin password
image_publisher = "MicrosoftWindowsServer"  # Replace with your desired image publisher ('MicrosoftWindowsServer', 'MicrosoftWindowsDesktop' etc.)
image_offer = "WindowsServer"               # Replace with your desired image offer ('WindowsServer', 'WindowsServerSemiAnnual' etc.)
image_sku = "2019-Datacenter"               # Replace with your desired image SKU ('2019-Datacenter', '2016-Datacenter' etc.)
image_version = "latest"                    # Replace with your desired image version ('latest', '2004.14.7' etc.)

# Initialize Azure credentials
credentials = DefaultAzureCredential()

# Initialize Compute and Resource Management clients
compute_client = ComputeManagementClient(credentials, "<Azure Subscription ID>")
resource_client = ResourceManagementClient(credentials, "<Azure Subscription ID>")

# --- Resource Group ---
print(f"Checking if the resource group exists: {resource_group_name}")
if not resource_client.resource_groups.check_existence(resource_group_name):
    resource_client.resource_groups.create_or_update(resource_group_name, {"location": location})
    print(f"Resource group created: {resource_group_name}")
else:
    print(f"Resource group already exists: {resource_group_name}")

# --- VM Configuration ---
print(f"Creating VM configuration for {vm_name}")
vm_config = {
    "location": location,
    "os_profile": {
        "computer_name": vm_name,
        "admin_username": admin_username,
        "admin_password": admin_password
    },
    "hardware_profile": {
        "vm_size": vm_size
    },
    "storage_profile": {
        "image_reference": {
            "publisher": image_publisher,
            "offer": image_offer,
            "sku": image_sku,
            "version": image_version
        }
    },
    "network_profile": {
        "network_interfaces": [{
            "id": resource_client.network_interfaces.get(resource_group_name, f"{vm_name}-nic").id
        }]
    }
}

# --- Virtual Machine ---
print(f"Checking if the virtual machine exists: {vm_name}")
if not compute_client.virtual_machines.check_existence(resource_group_name, vm_name):
    compute_client.virtual_machines.create_or_update(resource_group_name, vm_name, vm_config)
    print(f"Virtual Machine created: {vm_name}")
else:
    print(f"Virtual Machine already exists: {vm_name}")
