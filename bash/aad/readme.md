### newuser-in-newgroup:

This script simplifies the process of creating a new user and group in Azure Active Directory (Azure AD) using the Azure CLI.

### Prerequisites

Before running the script, make sure to uncomment and fill in the necessary information. Such as the display name, UPN, and password for the new user, as well as the name for the new group.

Please note that this script assumes you have already installed the Azure CLI on your machine and authenticated to your Azure AD tenant using `az login`. If you haven't installed the Azure CLI or logged in, you can uncomment the respective lines in the script to install and authenticate before performing the Azure AD operations.

Always test the script in a controlled environment and ensure you have the necessary permissions and access rights to perform the operations. Additionally, be careful when handling user passwords and avoid hardcoding sensitive information in your scripts.

### Script Explanation

The script performs the following actions:

1. Creates a new user in Azure AD with the specified display name, UPN, and password. The new user is enabled by default.
2. Creates a new security-enabled group in Azure AD with the specified display name.
3. Outputs a message indicating that the new user and group have been created.

Please note that this script assumes that you have already installed the Azure CLI on your machine. If you haven't, you can uncomment the first line to install it.