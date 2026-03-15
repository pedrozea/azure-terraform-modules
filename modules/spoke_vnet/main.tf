# ------------------------------------------------------------------------------
# Spoke Virtual Network Module - Main
# ------------------------------------------------------------------------------

# Creates an Azure Spoke Virtual Network

# ------------------------------------------------------------------------------
# Virtual Network - Base Module
# ------------------------------------------------------------------------------
module "vnet" {
  source = "../virtual_network"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Virtual Network Peering - Spoke to Hub
# ------------------------------------------------------------------------------
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peering-${var.name}-to-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = module.vnet.vnet_name
  remote_virtual_network_id    = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  # Only use true if you already have a VPN Gateway in the Hub
  use_remote_gateways = var.use_remote_gateways
}

# ------------------------------------------------------------------------------
# Virtual Network Peering - Hub to Spoke
# ------------------------------------------------------------------------------
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peering-hub-to-${var.name}"
  resource_group_name          = var.hub_resource_group_name
  virtual_network_name         = var.hub_vnet_name
  remote_virtual_network_id    = module.vnet.vnet_id
  allow_virtual_network_access = true
  # Allow the Spoke to use the Hub Gateway
  allow_gateway_transit = var.allow_gateway_transit
}

# ------------------------------------------------------------------------------
# Route Table (UDR) - "Force traffic to the Firewall"
# ------------------------------------------------------------------------------
resource "azurerm_route_table" "spoke_udr" {
  name                = "rt-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  route {
    name           = "bypass-fw-for-bastion"
    address_prefix = var.bastion_subnet_prefix
    next_hop_type  = "VnetLocal"
  }

  route {
    name                   = "default-to-hub-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_firewall_private_ip
  }
}

# ------------------------------------------------------------------------------
# Subnet Route Table Association - Spoke UDR
# ------------------------------------------------------------------------------
resource "azurerm_subnet_route_table_association" "spoke_udr_assoc" {
  # Iterate over the map of subnets returned by the base module
  for_each       = module.vnet.subnet_ids
  subnet_id      = each.value
  route_table_id = azurerm_route_table.spoke_udr.id
}
