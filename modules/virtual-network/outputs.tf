# ------------------------------------------------------------------------------
# Virtual Network Module - Outputs
# ------------------------------------------------------------------------------

output "id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet names to their resource IDs."
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_id" {
  description = "ID of the first subnet. Use subnet_ids when multiple subnets exist."
  value       = length(azurerm_subnet.this) > 0 ? values(azurerm_subnet.this)[0].id : null
}
