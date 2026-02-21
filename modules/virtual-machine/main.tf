# ------------------------------------------------------------------------------
# Virtual Machine Module - Main Resources
# ------------------------------------------------------------------------------
# Creates Linux and/or Windows VMs with optional public IPs.
# Each VM gets a NIC; public IP is optional per VM.

# ------------------------------------------------------------------------------
# Network Interfaces
# ------------------------------------------------------------------------------
resource "azurerm_network_interface" "this" {
  for_each = var.vms

  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address != null ? "Static" : "Dynamic"
    private_ip_address            = each.value.private_ip_address
    public_ip_address_id          = each.value.create_public_ip ? azurerm_public_ip.this[each.key].id : null
  }
}

# ------------------------------------------------------------------------------
# Public IPs (Optional per VM)
# ------------------------------------------------------------------------------
resource "azurerm_public_ip" "this" {
  for_each = { for k, v in var.vms : k => v if v.create_public_ip }

  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Linux Virtual Machines
# ------------------------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "this" {
  for_each = { for k, v in var.vms : k => v if v.os_type == "linux" }

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = each.value.size
  admin_username      = each.value.admin_username
  tags                = var.tags

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = each.value.ssh_public_key
  }

  network_interface_ids = [azurerm_network_interface.this[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk_type
    disk_size_gb         = each.value.os_disk_size_gb
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_uri != null ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }
}

# ------------------------------------------------------------------------------
# Windows Virtual Machines
# ------------------------------------------------------------------------------
resource "azurerm_windows_virtual_machine" "this" {
  for_each = { for k, v in var.vms : k => v if v.os_type == "windows" }

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  tags                = var.tags

  network_interface_ids = [azurerm_network_interface.this[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk_type
    disk_size_gb         = each.value.os_disk_size_gb
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_uri != null ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }
}
