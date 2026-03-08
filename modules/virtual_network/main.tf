# ------------------------------------------------------------------------------
# Virtual Network Module - Main Resources
# ------------------------------------------------------------------------------
# Creates an Azure Virtual Network and subnets.

# ------------------------------------------------------------------------------
# Virtual Network
# ------------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Subnets
# ------------------------------------------------------------------------------
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}
