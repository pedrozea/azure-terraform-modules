# ------------------------------------------------------------------------------
# Virtual Network Module - Provider Requirements
# ------------------------------------------------------------------------------
# Pins Terraform and Azure provider versions for consistent, reproducible runs.

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
