# ------------------------------------------------------------------------------
# Virtual Network Module - Main Resources
# ------------------------------------------------------------------------------
# Creates an Azure Virtual Network with configurable subnets.
# Supports optional subnet delegation for services (AKS, Azure Firewall, etc.).

# ------------------------------------------------------------------------------
# Virtual Network
# ------------------------------------------------------------------------------
resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Subnets
# ------------------------------------------------------------------------------
# Each subnet can optionally delegate to Azure services (e.g., AKS, Firewall).
# Omit delegation_name to create a standard workload subnet.
resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.address_prefix]

  # Delegation is only applied when explicitly configured
  dynamic "delegation" {
    for_each = coalesce(each.value.delegation_name, "") != "" ? [1] : []
    content {
      name = each.value.delegation_name

      service_delegation {
        name    = each.value.delegation_service
        actions = each.value.delegation_actions
      }
    }
  }
}
