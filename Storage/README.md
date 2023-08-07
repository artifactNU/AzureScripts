### Azure-Create-StorageAcc:
This script connects to your Azure account, creates a new Azure Storage Account, and then creates a Blob Container within that account.

### Script Explanation
It defines a function New-AzStorageAccountWithContainer that creates a new Storage Account and Blob Container in that account. The function accepts parameters such as the resource group name, Storage Account name, location, and container name.
Inside the main script block, it sets the variables for the resource group, Storage Account, and Blob Container.
The script checks if the specified resource group exists. If not, it creates the resource group using the New-AzResourceGroup cmdlet.
Finally, it calls the New-AzStorageAccountWithContainer function with the provided parameters to create the Storage Account and Blob Container.

-----------------------------------------------------------------

### Azure-Storage-Upload:
This script uploads a local file to an Azure Blob Container.

### Prerequisites
A Storage Account and Blob Container must already exist.

### Script Explanation
The script sets the variables for the resource group, Storage Account, Blob Container, and the file path to upload.
It connects to your Azure account using the Connect-AzAccount cmdlet.
It defines a function Upload-FileToBlobContainer that uploads a file to a specified Blob Container. The function accepts parameters such as the resource group name, Storage Account name, Blob Container name, and file path.
Inside the main script block, the script calls the Upload-FileToBlobContainer function with the provided parameters to upload the file to the specified Blob Container.
Note: Ensure that you have appropriate permissions to access the specified Storage Account and Blob Container, and that the file you want to upload exists at the specified local file path.
