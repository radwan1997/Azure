


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
.
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




