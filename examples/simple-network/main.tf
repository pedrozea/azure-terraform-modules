# ------------------------------------------------------------------------------
# Simple Network Example
# ------------------------------------------------------------------------------
# Minimal example: single VNet with subnets and NSG.
# Demonstrates virtual-network and network-security-group modules.

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# ------------------------------------------------------------------------------
# Resource Group
# ------------------------------------------------------------------------------
module "rg" {
  source = "../../modules/resource-group"

  name     = "rg-simple-${var.environment}"
  location = var.location
}

# ------------------------------------------------------------------------------
# Virtual Network
# ------------------------------------------------------------------------------
module "virtual_network" {
  source = "../../modules/virtual-network"

  name                = "vnet-simple-${var.environment}"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]

  subnets = {
    default = { address_prefix = "10.0.1.0/24" }
    apps    = { address_prefix = "10.0.2.0/24" }
  }
}

# ------------------------------------------------------------------------------
# Network Security Group
# ------------------------------------------------------------------------------
module "nsg" {
  source = "../../modules/network-security-group"

  name                = "nsg-simple-${var.environment}"
  resource_group_name = module.rg.name
  location            = module.rg.location

  security_rules = {
    allow-ssh = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  subnet_ids = [module.virtual_network.subnet_ids["default"]]
}
