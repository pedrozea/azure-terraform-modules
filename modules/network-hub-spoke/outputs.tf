# ------------------------------------------------------------------------------
# Network Hub-Spoke Module - Outputs
# ------------------------------------------------------------------------------

output "hub_vnet_id" {
  description = "ID of the hub virtual network."
  value       = azurerm_virtual_network.hub.id
}

output "hub_subnet_ids" {
  description = "Map of hub subnet names to IDs."
  value       = { for k, v in azurerm_subnet.hub : k => v.id }
}

output "spoke_vnet_ids" {
  description = "Map of spoke identifiers to VNet IDs."
  value       = { for k, v in azurerm_virtual_network.spokes : k => v.id }
}

output "spoke_subnet_ids" {
  description = "Map of spoke subnet keys (spoke_key-subnet_key) to IDs."
  value       = { for k, v in azurerm_subnet.spokes : k => v.id }
}
