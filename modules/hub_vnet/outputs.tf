# ------------------------------------------------------------------------------
# Hub Virtual Network Module - Output Variables
# ------------------------------------------------------------------------------

output "vnet_id" {
  description = "ID of the Hub virtual network."
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the Hub virtual network."
  value       = module.vnet.vnet_name
}

output "subnet_ids" {
  description = "Map of all subnet names to their resource IDs."
  value       = module.vnet.subnet_ids
}
