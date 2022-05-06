output "nat_gateway_name" {
  description = "Name of the Provisioned NAT Gateway"
  value       =  azurerm_nat_gateway.nat_gtw.name
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       =  azurerm_nat_gateway.nat_gtw.resource_group_name
}
