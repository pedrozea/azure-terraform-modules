# ------------------------------------------------------------------------------
# Log Analytics Workspace Module - Main Resources
# ------------------------------------------------------------------------------
# Creates an Azure Log Analytics workspace for centralized logging and monitoring.
# Use with Azure Monitor, VM insights, and custom log collection.

# ------------------------------------------------------------------------------
# Log Analytics Workspace
# ------------------------------------------------------------------------------
resource "azurerm_log_analytics_workspace" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}
