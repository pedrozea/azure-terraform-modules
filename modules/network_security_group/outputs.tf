# ------------------------------------------------------------------------------
# Network Security Group Module - Outputs
# ------------------------------------------------------------------------------

output "id" {
  description = "The ID of the Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}
