# ------------------------------------------------------------------------------
# Azure Linux VM Module - Outputs
# ------------------------------------------------------------------------------

output "vm_id" {
  description = "ID of the Linux VM"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "private_ip" {
  description = "Private IP address of the Linux VM"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "subnet_id" {
  description = "ID of the subnet where the VM is deployed"
  value       = var.subnet_id
}
