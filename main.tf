resource "azurerm_nat_gateway" "nat_gtw" {
  name                    = var.nat_gtw_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  public_ip_address_ids   = var.pub_ip_id
  public_ip_prefix_ids    = var.pub_ip_prefix_id
  sku_name                = var.sku_name
  //idle_timeout_mins       = var.idle_timeout_mins
  zones                   = var.availability_zone
}


