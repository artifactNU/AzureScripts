### Basic-Vnet-subnetNSG:
Configuring Azure networking can be quite involved, as it can involve creating and configuring various network components like virtual networks, subnets, network security groups, and more.
This is a PowerShell script to create a basic Azure virtual network with a subnet and a network security group (NSG).

### Prerequisites
Before running the script, make sure to uncomment and fill in the necessary information such as the name of the desired:
Resource group
Virtual network
Subnet
Network security group
and any specific network security rules you want to add.

### Script Explanation
The script performs the following actions:

    1. Creates a new Azure Virtual Network with the specified name and address prefix (10.0.0.0/16).
    2. Adds a new subnet to the Virtual Network with the specified name and address prefix (10.0.1.0/24).
    3. Creates a new Network Security Group with the specified name.
    4. Allows inbound Remote Desktop Protocol (RDP) traffic (example rule) to the subnet from the Internet.
    5. Associates the created NSG with the newly added subnet.


Always test the script in a controlled environment and ensure you have the necessary permissions and access rights to perform the operations.
Additionally, customize the network security rules according to your specific networking requirements.
Azure networking is a vast topic, and the above script provides a basic example of creating a virtual network, subnet, and network security group.
Depending on your project's needs, you may need to explore more advanced network configurations and services offered by Azure.
