# ------------------------------------------------------------------------------
# Virtual Machine Module - Outputs
# ------------------------------------------------------------------------------

output "vm_ids" {
  description = "Map of VM names to resource IDs."
  value = merge(
    { for k, v in azurerm_linux_virtual_machine.this : k => v.id },
    { for k, v in azurerm_windows_virtual_machine.this : k => v.id }
  )
}

output "nic_ids" {
  description = "Map of VM names to network interface IDs."
  value       = { for k, v in azurerm_network_interface.this : k => v.id }
}

output "private_ip_addresses" {
  description = "Map of VM names to private IP addresses."
  value       = { for k, v in azurerm_network_interface.this : k => v.private_ip_address }
}
