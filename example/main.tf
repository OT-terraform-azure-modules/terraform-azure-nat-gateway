terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.46.0"
    }
  }

  required_version = ">= 0.15"
}

provider "azurerm" {
  features {}
}

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
  sku_name          = "Standard"
  availability_zone = ["1"]
}