# ------------------------------------------------------------------------------
# Network Security Group Module - Main Resources
# ------------------------------------------------------------------------------
# Creates an NSG with configurable rules and optional subnet associations.
# Use subnet_ids to attach this NSG to one or more subnets.

# ------------------------------------------------------------------------------
# Network Security Group
# ------------------------------------------------------------------------------
resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Security Rules
# ------------------------------------------------------------------------------
# Each rule defines allow/deny behavior for traffic matching the criteria.
# Priority must be unique per NSG (100-4096). Lower numbers take precedence.
resource "azurerm_network_security_rule" "this" {
  for_each = var.security_rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  description                 = lookup(each.value, "description", null)
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# ------------------------------------------------------------------------------
# Subnet Associations
# ------------------------------------------------------------------------------
# Associates this NSG with the specified subnets. Uses toset to deduplicate IDs.
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = toset(var.subnet_ids)

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.this.id
}
