# basic-vnet-subnetnsg

This is a Bash script to create a basic Azure virtual network with a subnet and a network security group (NSG).

## Prerequisites

Before running the script, make sure to uncomment and fill in the necessary information such as the name of the desired:

- Resource group
- Virtual network
- Subnet
- Network security group
- Any specific network security rules you want to add.

Please note that this script assumes you have already installed the Azure CLI on your machine and authenticated to your Azure account. If you haven't installed the Azure CLI or logged in, you can follow the instructions in the Azure documentation to install and authenticate before performing the Azure operations.

Always test the script in a controlled environment and ensure you have the necessary permissions and access rights to perform the operations. Additionally, be careful when handling sensitive information and avoid hardcoding passwords or other sensitive data in your scripts.

## Script Explanation

The script performs the following actions:

1. Creates a new Azure Virtual Network with the specified name and address prefix (10.0.0.0/16).
2. Adds a new subnet to the Virtual Network with the specified name and address prefix (10.0.1.0/24).
3. Creates a new Network Security Group with the specified name.
4. Allows inbound Remote Desktop Protocol (RDP) traffic (example rule) to the subnet from the Internet.
5. Associates the created NSG with the newly added subnet.

Please note that the script includes an example rule to allow inbound RDP traffic to the subnet from the Internet. You can modify this rule or add additional rules as needed to meet your specific networking requirements.

## Usage

To use the script, simply run it in a Bash shell or terminal. The script will prompt you for any required input values that are not already specified in the script.

## Conclusion

This script provides a simple way to create a basic Azure virtual network with a subnet and a network security group. You can modify the script or add additional Azure CLI commands to further customize your networking configuration.