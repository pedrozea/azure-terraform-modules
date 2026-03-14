# ------------------------------------------------------------------------------
# Azure Firewall Module - Outputs
# ------------------------------------------------------------------------------

output "private_ip" {
  description = "Private IP of the Firewall for use in Route Tables (UDRs)"
  value       = azurerm_firewall.fw.ip_configuration[0].private_ip_address
}
