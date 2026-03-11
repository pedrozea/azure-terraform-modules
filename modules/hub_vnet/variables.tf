# ------------------------------------------------------------------------------
# Hub Virtual Network Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the Hub virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "address_space" {
  description = "Address space for the Hub Virtual Network"
  type        = list(string)
}

# --- Hub-specific variables ---

variable "firewall_subnet_prefix" {
  description = "Address prefix for the AzureFirewallSubnet. Minimum /26 is recommended."
  type        = string
  default     = null # Permite que sea opcional si no lo despliegan de inmediato
}

variable "bastion_subnet_prefix" {
  description = "Address prefix for the AzureBastionSubnet. Minimum /26."
  type        = string
  default     = null
}

variable "gateway_subnet_prefix" {
  description = "Address prefix for the GatewaySubnet (VPN/ExpressRoute). Minimum /27."
  type        = string
  default     = null
}

variable "extra_subnets" {
  description = "Map of any extra subnets (e.g., Jumpbox, Shared Services). Key = name, Value = prefix."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
