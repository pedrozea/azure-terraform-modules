# ------------------------------------------------------------------------------
# Network Hub-Spoke Module - Main Resources
# ------------------------------------------------------------------------------
# Implements the hub-and-spoke network pattern:
# - Hub VNet: Central services (Firewall, VPN Gateway, etc.)
# - Spoke VNets: Workload isolation
# - Bidirectional peering between hub and each spoke

# ------------------------------------------------------------------------------
# Hub Virtual Network
# ------------------------------------------------------------------------------
# Central VNet for shared services. Typically hosts Azure Firewall, VPN Gateway.
resource "azurerm_virtual_network" "hub" {
  name                = var.hub_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.hub_address_space]
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Hub Subnets
# ------------------------------------------------------------------------------
# Use reserved names for Azure services: AzureFirewallSubnet, GatewaySubnet.
resource "azurerm_subnet" "hub" {
  for_each = var.hub_subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [each.value.address_prefix]
}

# ------------------------------------------------------------------------------
# Spoke Virtual Networks
# ------------------------------------------------------------------------------
# One VNet per spoke. Each spoke has isolated address space and subnets.
resource "azurerm_virtual_network" "spokes" {
  for_each = var.spokes

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [each.value.address_space]
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Spoke Subnets
# ------------------------------------------------------------------------------
# Flattens spoke config into a single map keyed by "spoke_key-subnet_key".
resource "azurerm_subnet" "spokes" {
  for_each = merge([
    for spoke_key, spoke in var.spokes : {
      for subnet_key, subnet in spoke.subnets :
      "${spoke_key}-${subnet_key}" => {
        spoke_key      = spoke_key
        subnet_key     = subnet_key
        address_prefix = subnet.address_prefix
      }
    }
  ]...)

  name                 = each.value.subnet_key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spokes[each.value.spoke_key].name
  address_prefixes     = [each.value.address_prefix]
}

# ------------------------------------------------------------------------------
# VNet Peering: Hub -> Spokes
# ------------------------------------------------------------------------------
# Allows hub to reach spoke networks. allow_forwarded_traffic enables Azure Firewall.
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  for_each = var.spokes

  name                         = "hub-to-${each.key}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spokes[each.key].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = false
}

# ------------------------------------------------------------------------------
# VNet Peering: Spokes -> Hub
# ------------------------------------------------------------------------------
# Allows spokes to reach hub. use_remote_gateways lets spokes use hub VPN/ER.
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  for_each = var.spokes

  name                         = "${each.key}-to-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.spokes[each.key].name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = var.use_remote_gateways
}
