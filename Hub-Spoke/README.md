


Again write this file 

FIRST let me give you quick creating 


Today we will deploy a hub-spoke toppology conatin:
(1) Azure virtual networks in a hub and spoke 
(2) Azure Firewall
(3) Bastion host
(4) VPN gateway
(5) Virtual Machine

*All resources will send diagnostics to Azure Log Analytics

First let's begin with creating RG
az group create --name RG_name --location RG_loc

now begin with Infra 

az deployment group create \
    --resource-group hub-spoke \
    --template-uri JASON_TEMPLATE_LINK




