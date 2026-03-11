# ------------------------------------------------------------------------------
# Spoke Virtual Network Module - Outputs
# ------------------------------------------------------------------------------

output "vnet_id" {
  description = "ID of the Spoke Virtual Network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the Spoke Virtual Network"
  value       = module.vnet.vnet_name
}

output "subnet_ids" {
  description = "Map of subnet names to their respective IDs"
  value       = module.vnet.subnet_ids
}

output "route_table_id" {
  description = "ID of the Route Table (UDR) created for this Spoke"
  value       = azurerm_route_table.spoke_udr.id
}
