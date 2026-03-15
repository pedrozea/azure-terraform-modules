# ------------------------------------------------------------------------------
# Azure Bastion Module - Main Resources
# ------------------------------------------------------------------------------

# Creates an Azure Bastion instance

# ------------------------------------------------------------------------------
# Public IP for Azure Bastion
# ------------------------------------------------------------------------------
resource "azurerm_public_ip" "bastion_pip" {
  name                = "pip-bastion-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# ------------------------------------------------------------------------------
# Azure Bastion
# ------------------------------------------------------------------------------
resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}
