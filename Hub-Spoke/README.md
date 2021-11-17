


Again write a new lab using https://github.com/neilpeterson and Microsoft docs

FIRST let me give you quick creating URL for GitHub file
(1) Start with the raw URL to the template in your repo
(2) convert the URL to a URL-encoded value.
Now you can do it online or using Powershell.
$url = "yuor_url_for_file"
[uri]::EscapeDataString($url)
(3) now add your encoded_link to:
https://portal.azure.com/#create/Microsoft.Template/uri/encoded_file_link
(4) Congrats!!!!! You have your full URL for the link, now you can use it in our lab.
Ready?
let's begin

Today we will deploy a hub-spoke toppology conatin:
(1) Azure virtual networks in a hub and spoke 
(2) Azure Firewall
(3) Bastion host
(4) VPN gateway
(5) Virtual Machine

*All resources will send diagnostics to Azure Log Analytics

let's take a quick look to our jason file parameters.

---------------------------------------------------------------------------------------------------------------
Parameter	    Type	            Description	                                                    Default
windowsVMCount  	int	            Number of Windows virtual machines to create in spoke network.  	0
linuxVMCount	    int	            Number of Linux virtual machines to create in spoke network.	    0
adminUserName	    string	        If deploying virtual machines, the admin user name.	                null
adminPassword	    securestring	If deploying virtual machines, the admin password.	                null
deployVpnGateway	bool	        If true, a vnet gateway is deployed into the hub network	        false
hubNetwork	        object	        Network configuration for the hub virtual network.      	[see template]
spokeOneNetwork	    object	        Network configuration for the first spoke virtual network.	[see template]
spokeTwoNetwork	    object	        Network configuration for the second spoke virtual network.	[see template]
vpnGateway	        object	        Network configuration for the vpn gateway.	                [see template]
bastionHost	        object	        Configuration for the Bastion host.	                        [see template]
azureFirewall	    object	        Network configuration for the firewall instance.	        [see template]
location	        string	        Deployment location.	                            resourceGroup().locatio

---------------------------------------------------------------------------------------------------------------


Now time for Deploying our code.
First let's begin with creating RG
az group create --name RG_name --location RG_loc

now begin with Infra 

az deployment group create \
    --resource-group hub-spoke \
    --template-uri JASON_TEMPLATE_LINK


------------------------------------------------------------------------
One of choices to get template is Deploy template spec
Okay, let me show you how?
if you have teplate like what you have now and want to run it in your environment, one of choices is store ARM Template in Azure and use it anytime and share it with your team too using (RBAC) no need to SAS tokens beside users just need read access and use it with powershell or DevOps pipeline.

now let's begin:
Create a template spec by using:
az ts create \
  --name name_for_spec \
  --version "1.0a" \
  --resource-group RG_for_templeate \
  --location "RG_locat" \
  --template-file "template_file_in_local_path"

Just that you now have your store from templates

let's check it:
az ts list # it will list all your templates

Do you want to see specific  tempale details and with specific virsion:

az ts show \
    --name name_for_spec \
    --resource-group RG_for_templeate \
    --version "1.0a" # Specific version

now you do it, what about deploy it now?
Okay let me show you how.
this tempalte in Azure now is resource and in Azure evey resource have an resource ID.
we will use this resource id to get path for out template like URI

id = "your_template_json_file_ID"
az deployment group create \
  --resource-group RG_for_new_INFRA \
  --template-spec $id

for get ID (just in practice )

id = $(az ts show --name name_for_spec --resource-group RG_for_templeate --version "1.0a" --query "id")

----
What about pass parameters in your main file?
you have to choices:
(1) Pass parameter inline
az deployment group create \
  --resource-group RG_for_new_INFRA \
  --template-spec $id \ # Main template file
  --parameters storageAccountType='Standard_GRS' #for example change storage type in main template


(2) Create a local parameter file then pass it to main file
az deployment group create \
  --resource-group demoRG \
  --template-spec $id \ # Main template file
  --parameters "local_para_file"
