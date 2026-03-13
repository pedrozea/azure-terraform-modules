# ------------------------------------------------------------------------------
# Resource Group Module - Main Resources
# ------------------------------------------------------------------------------

# Creates an Azure Resource Group as a container for other resources.

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
