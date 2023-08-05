These scripts are designed to facilitate the creation of an Azure Storage Account and Blob Container, as well as the upload of a file to that container. Before executing the scripts, ensure that you have the Azure PowerShell module installed and configured with the necessary permissions to access your Azure account.

-----------------------------------------------------------------

Script 1: Create Azure Storage Account and Blob Container
This script connects to your Azure account, creates a new Azure Storage Account, and then creates a Blob Container within that account.

Prerequisites
Azure PowerShell module must be installed.
You need to have an active Azure account and appropriate permissions.
Usage
Open a PowerShell session.
Copy and paste the script into the PowerShell session.
Modify the following variables as per your requirements:
$resourceGroupName: The desired name of the resource group in which the Storage Account will be created.
$storageAccountName: The desired name for your Storage Account.
$location: The desired Azure region where the Storage Account will be created.
$containerName: The desired name for the Blob Container within the Storage Account.
$skuName: The desired SKU for the Storage Account (e.g., Standard_LRS, Standard_GRS, etc.).
Execute the script.
Script Explanation
The script starts by connecting to your Azure account using the Connect-AzAccount cmdlet.
It defines a function New-AzStorageAccountWithContainer that creates a new Storage Account and Blob Container in that account. The function accepts parameters such as the resource group name, Storage Account name, location, and container name.
Inside the main script block, it sets the variables for the resource group, Storage Account, and Blob Container.
The script checks if the specified resource group exists. If not, it creates the resource group using the New-AzResourceGroup cmdlet.
Finally, it calls the New-AzStorageAccountWithContainer function with the provided parameters to create the Storage Account and Blob Container.

-----------------------------------------------------------------

Script 2: Upload File to Azure Blob Container
This script uploads a local file to an Azure Blob Container.

Prerequisites
Azure PowerShell module must be installed.
You need to have an active Azure account and appropriate permissions.
A Storage Account and Blob Container must already exist.
Usage
Open a PowerShell session.
Copy and paste the script into the PowerShell session.
Modify the following variables as per your requirements:
$resourceGroupName: The name of the resource group where the Storage Account exists.
$storageAccountName: The name of your existing Storage Account.
$containerName: The name of the Blob Container where you want to upload the file.
$fileToUpload: The local file path of the file you want to upload.
Execute the script.
Script Explanation
The script sets the variables for the resource group, Storage Account, Blob Container, and the file path to upload.
It connects to your Azure account using the Connect-AzAccount cmdlet.
It defines a function Upload-FileToBlobContainer that uploads a file to a specified Blob Container. The function accepts parameters such as the resource group name, Storage Account name, Blob Container name, and file path.
Inside the main script block, the script calls the Upload-FileToBlobContainer function with the provided parameters to upload the file to the specified Blob Container.
Note: Ensure that you have appropriate permissions to access the specified Storage Account and Blob Container, and that the file you want to upload exists at the specified local file path.
