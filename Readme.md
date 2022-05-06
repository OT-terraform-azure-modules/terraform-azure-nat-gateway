Azure NAT Gateway Terraform Module
=============================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage]

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

 NAT Gateway module can be used for outbound Internet connectivity for virtual networks. When configured on a subnet, all outbound connectivity uses the Virtual Network NAT's static public IP addresses.

Terraform versions
------------------
Terraform v0.15.4


Usage
------

```hcl
module "res_group" {
  source                  = "git::git@gitlab.com:ot-azure/terraform/rg.git?ref=master"
  resource_group_name     = "anu_rg"
  resource_group_location = "West Europe"
  lock_level_value        = ""
  tag_map = {
    Name = "AzureResourceGroup"
  }
}

resource "azurerm_public_ip" "pubip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = module.res_group.resource_group_name
  location            = module.res_group.resource_group_location
  allocation_method   = "Static"
  sku                 = "Standard"
  availability_zone   = "1"

  tags = {
    environment = "Testing"
  }
}

resource "azurerm_public_ip_prefix" "ip_prefix" {
  name                = "acceptanceTestPublicIpPrefix1"
  location            = module.res_group.resource_group_location
  resource_group_name = module.res_group.resource_group_name
  availability_zone   = "1"
  prefix_length       = 31

  tags = {
    environment = "Testing"
  }
}

module "nat_gateway" {
  source              = "../"
  nat_gtw_name        = "Anubhav_NAT"
  resource_group_name = module.res_group.resource_group_name
  location            = module.res_group.resource_group_location
  pub_ip_id           = azurerm_public_ip.pubip.*.id
  pub_ip_prefix_id    = azurerm_public_ip_prefix.ip_prefix.*.id
  sku_name            = "Standard"
  availability_zone   = ["1"]
}
```


Resources
------
| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_public_ip.pubip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip_prefix.ip_prefix](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix) | resource |
| [azurerm_nat_gateway.nat_gtw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |




Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of Resource Group | `string` |  | yes |
| location | Location of NAT gateway | `string` |  | yes |
| nat_gtw_name | Name of our NAT Gateway | `string` | | yes |
| sku_name | stock-keeping unit, defines a specific business product that Microsoft sell | `string` | Standard | yes |
| availability_zone | availability zone where the NAT Gateway will be provisioned | `list(any)` | 1 | yes |
| pub_ip_id | ID of Public IP. This we will get from other module | `list` | | no |
| pub_ip_prefix_id | ID of Public IP prefix | `list` | | no |




Output
------
| Name | Description |
|------|-------------|  
| nat_gateway_name | Name of the Provisioned NAT Gateway |
| resource_group_name | Name of the resource group |


### Contributors
|  [![Anubhav Rana][Anubhav_avatar]][Anubhav_homepage]<br/>[Anubhav Rana][Anubhav_homepage] |


  [anubhav_homepage]: https://gitlab.com/anubhavrana008
  [anubhav_avatar]: https://gitlab.com/uploads/-/system/user/avatar/10197169/avatar.png?width=400
   

https://gitlab.com/anubhavrana008
