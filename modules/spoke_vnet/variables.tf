# ------------------------------------------------------------------------------
# Spoke Virtual Network Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the Spoke Virtual Network"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "address_space" {
  description = "Address space for the Spoke Virtual Network"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the Spoke Virtual Network"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags for the Spoke Virtual Network"
  type        = map(string)
  default     = {}
}

# --- Hub connection variables ---

variable "hub_vnet_id" {
  description = "ID of the Hub Virtual Network"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the Hub Virtual Network"
  type        = string
}

variable "hub_resource_group_name" {
  description = "Name of the resource group where the Hub Virtual Network is deployed"
  type        = string
}

variable "hub_firewall_private_ip" {
  description = "Private IP address of the Azure Firewall in the Hub"
  type        = string
}

variable "use_remote_gateways" {
  type        = bool
  default     = false
  description = "Set to true if the Hub has a VPN Gateway that this Spoke should use."
}

variable "allow_gateway_transit" {
  type        = bool
  default     = false
  description = "Set to true in the Hub if you want the Spoke to pass through its Gateway."
}
