# ------------------------------------------------------------------------------
# Hub Virtual Network Module - Output Variables
# ------------------------------------------------------------------------------

output "vnet_id" {
  description = "The ID of the Hub virtual network."
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The name of the Hub virtual network."
  value       = module.vnet.vnet_name
}

output "subnet_ids" {
  description = "Map of all subnet names to their resource IDs."
  value       = module.vnet.subnet_ids
}

output "firewall_subnet_id" {
  description = "The ID of the Azure Firewall Subnet (if created)."
  # Usamos try por si la subred no se creó, para que Terraform no falle
  value = try(module.vnet.subnet_ids["AzureFirewallSubnet"], null)
}
