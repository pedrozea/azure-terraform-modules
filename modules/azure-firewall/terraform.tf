# ------------------------------------------------------------------------------
# Azure Firewall Module - Provider Requirements
# ------------------------------------------------------------------------------
# Deploy in a subnet named AzureFirewallSubnet with /26 or larger.

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
