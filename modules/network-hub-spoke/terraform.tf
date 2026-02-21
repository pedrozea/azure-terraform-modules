# ------------------------------------------------------------------------------
# Network Hub-Spoke Module - Provider Requirements
# ------------------------------------------------------------------------------
# Pattern module that creates a hub-and-spoke topology with VNet peering.

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
