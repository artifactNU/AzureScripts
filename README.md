# Scripts for Azure Automation
This project is designed as a learning platform to enhance skills in both PowerShell and bash scripting. The scripts provided here are carefully crafted to showcase real-world scenarios, empowering you to manage Azure resources efficiently.

### Prerequisites:
You need an active Azure account with the required permissions.

### To Get Started:
PowerShell: https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-4.8.0
```
Install-Module -Name Az -Force
Connect-AzAccount
Get-AzSubscription
Select-AzSubscription -SubscriptionName "Your-Subscription-Name"
```
bash: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest
```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login
az account list --output table
az account set --subscription "Your-Subscription-Name"
```


### Script Customization:
Open a script in a text editor to tailor it to your needs.

### Execute a script:
Replace script-name with the name of the script you want to run.

#### PowerShell:
##### Navigate to the script folder in a PowerShell session and run with:
`
.\script-name.ps1
`
#### Bash:
##### Navigate to the script folder in a bash session and change the permission with:
`
chmod +x script-name.sh
`
##### Run with:
`
./script-name.sh
`
### License Information:
This project is distributed under the BSD 3-Clause License, allowing you the freedom to use, modify, and distribute the scripts while providing appropriate attribution.

