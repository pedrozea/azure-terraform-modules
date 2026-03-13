# ------------------------------------------------------------------------------
# Hub Virtual Network Module - Main
# ------------------------------------------------------------------------------
# Creates an Azure Hub Virtual Network and subnets.

locals {
  # Define mandatory subnets for the Hub VNet
  core_subnets = {
    "AzureFirewallSubnet" = var.firewall_subnet_prefix
    "AzureBastionSubnet"  = var.bastion_subnet_prefix
    "GatewaySubnet"       = var.gateway_subnet_prefix
  }

  # Filter out empty subnets (for optional Bastion or VPN deployment)
  active_core_subnets = {
    for k, v in local.core_subnets : k => v if v != null && v != ""
  }

  # Merge the core subnets with any additional subnets
  final_subnets = merge(local.active_core_subnets, var.extra_subnets)
}

# ------------------------------------------------------------------------------
# Virtual Network - Base Module
# ------------------------------------------------------------------------------
module "vnet" {
  source = "../virtual_network"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  subnets             = local.final_subnets
  tags                = var.tags
}
