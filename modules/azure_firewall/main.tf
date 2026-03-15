# ------------------------------------------------------------------------------
# Azure Firewall Module - Main Resources
# ------------------------------------------------------------------------------

# Creates an Azure Firewall instance

# --- Public IP for Azure Firewall ---
resource "azurerm_public_ip" "fw_pip" {
  name                = "pip-fw-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# --- Azure Firewall ---
resource "azurerm_firewall" "fw" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}

# --- Network Rule Collection ---
resource "azurerm_firewall_network_rule_collection" "rules" {
  # Creates the network rule collection if there are any network rules
  count = length(var.network_rules) > 0 ? 1 : 0

  name                = "fw-network-rules"
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"

  # Dynamic rule creation
  dynamic "rule" {
    for_each = var.network_rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}
