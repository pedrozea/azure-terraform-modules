# ------------------------------------------------------------------------------
# Lab Complete Example - Outputs
# ------------------------------------------------------------------------------

output "resource_group_name" {
  description = "Name of the resource group."
  value       = module.rg.name
}

output "hub_vnet_id" {
  description = "ID of the hub virtual network."
  value       = module.network_hub_spoke.hub_vnet_id
}

output "spoke_subnet_ids" {
  description = "Map of spoke subnet IDs."
  value       = module.network_hub_spoke.spoke_subnet_ids
}

output "firewall_private_ip" {
  description = "Private IP of the Azure Firewall."
  value       = module.azure_firewall.private_ip_address
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace."
  value       = module.log_analytics_workspace.id
}
