# ------------------------------------------------------------------------------
# Complete Lab Example
# ------------------------------------------------------------------------------
# Hub-spoke topology with Azure Firewall, NSGs, and Log Analytics.
# Demonstrates composition of multiple modules for a production-like lab.

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

  name     = "rg-lab-${var.environment}"
  location = var.location
  tags     = var.tags
}

# ------------------------------------------------------------------------------
# Hub-Spoke Network Topology
# ------------------------------------------------------------------------------
module "network_hub_spoke" {
  source = "../../modules/network-hub-spoke"

  hub_vnet_name       = "vnet-hub-${var.environment}"
  resource_group_name = module.rg.name
  location            = module.rg.location
  hub_address_space   = "10.0.0.0/16"
  tags                = var.tags

  hub_subnets = {
    AzureFirewallSubnet = { address_prefix = "10.0.1.0/26" }
    management          = { address_prefix = "10.0.2.0/24" }
  }

  spokes = {
    apps = {
      name          = "vnet-spoke-apps-${var.environment}"
      address_space = "10.1.0.0/16"
      subnets = {
        default = { address_prefix = "10.1.1.0/24" }
      }
    }
    data = {
      name          = "vnet-spoke-data-${var.environment}"
      address_space = "10.2.0.0/16"
      subnets = {
        default = { address_prefix = "10.2.1.0/24" }
      }
    }
  }
}

# ------------------------------------------------------------------------------
# NSG for Spoke Subnets
# ------------------------------------------------------------------------------
module "nsg_spoke" {
  source = "../../modules/network-security-group"

  name                = "nsg-spoke-${var.environment}"
  resource_group_name = module.rg.name
  location            = module.rg.location
  tags                = var.tags

  security_rules = {
    allow-rdp = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      destination_port_range     = "3389"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    }
    allow-ssh = {
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      destination_port_range     = "22"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    }
  }

  subnet_ids = values(module.network_hub_spoke.spoke_subnet_ids)
}

# ------------------------------------------------------------------------------
# Azure Firewall (Hub)
# ------------------------------------------------------------------------------
module "azure_firewall" {
  source = "../../modules/azure-firewall"

  name                = "afw-lab-${var.environment}"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.network_hub_spoke.hub_subnet_ids["AzureFirewallSubnet"]
  tags                = var.tags

  network_rules = [
    {
      name                  = "allow-https"
      source_addresses      = ["*"]
      destination_ports     = ["443"]
      destination_addresses = ["*"]
      protocols             = ["TCP"]
    }
  ]
}

# ------------------------------------------------------------------------------
# Log Analytics Workspace
# ------------------------------------------------------------------------------
module "log_analytics_workspace" {
  source = "../../modules/log-analytics-workspace"

  name                = "law-lab-${var.environment}"
  resource_group_name = module.rg.name
  location            = module.rg.location
  retention_in_days   = 30
  tags                = var.tags
}
