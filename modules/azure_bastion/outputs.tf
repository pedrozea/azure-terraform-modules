# ------------------------------------------------------------------------------
# Azure Bastion Module - Outputs
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Azure Bastion
# ------------------------------------------------------------------------------
output "id" {
  description = "The ID of the Azure Bastion host."
  value       = azurerm_bastion_host.bastion.id
}

output "dns_name" {
  description = "The name of the Azure Bastion host."
  value       = azurerm_bastion_host.bastion.dns_name
}

# ------------------------------------------------------------------------------
# Public IP for Azure Bastion
# ------------------------------------------------------------------------------
output "public_ip_address" {
  description = "The public IP address of the Azure Bastion host."
  value       = azurerm_public_ip.bastion_pip.ip_address
}
