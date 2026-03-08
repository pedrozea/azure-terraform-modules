# ------------------------------------------------------------------------------
# Azure Firewall Module - Main Resources
# ------------------------------------------------------------------------------
# Creates an Azure Firewall with optional network rules.
# Requires a dedicated subnet: AzureFirewallSubnet, minimum /26.

# ------------------------------------------------------------------------------
# Azure Firewall
# ------------------------------------------------------------------------------
resource "azurerm_firewall" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  tags                = var.tags

  ip_configuration {
    name                 = "fw-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.this.id
  }

  # Management config required for forced tunneling (Premium SKU)
  dynamic "management_ip_configuration" {
    for_each = var.management_subnet_id != null ? [1] : []
    content {
      name                 = "mgmt-config"
      subnet_id            = var.management_subnet_id
      public_ip_address_id = azurerm_public_ip.mgmt[0].id
    }
  }
}

# ------------------------------------------------------------------------------
# Firewall Public IP
# ------------------------------------------------------------------------------
resource "azurerm_public_ip" "this" {
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Management Public IP (Premium / Forced Tunneling)
# ------------------------------------------------------------------------------
resource "azurerm_public_ip" "mgmt" {
  count = var.management_subnet_id != null ? 1 : 0

  name                = "${var.name}-mgmt-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Network Rule Collection (Optional)
# ------------------------------------------------------------------------------
# Define outbound/inbound network rules. Omit network_rules for firewall-only deployment.
resource "azurerm_firewall_network_rule_collection" "this" {
  count = length(var.network_rules) > 0 ? 1 : 0

  name                = "default-network-rules"
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"

  dynamic "rule" {
    for_each = var.network_rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols             = rule.value.protocols
    }
  }
}
