# ------------------------------------------------------------------------------
# Network Hub-Spoke Module - Input Variables
# ------------------------------------------------------------------------------

variable "hub_vnet_name" {
  description = "Name of the hub virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "hub_address_space" {
  description = "Address space for the hub VNet (e.g., 10.0.0.0/16)."
  type        = string
}

variable "hub_subnets" {
  description = <<-EOT
    Map of hub subnets. Key = subnet name (e.g., AzureFirewallSubnet, GatewaySubnet).
    Value = object with address_prefix.
  EOT
  type = map(object({
    address_prefix = string
  }))
  default = {}
}

variable "spokes" {
  description = <<-EOT
    Map of spoke configurations. Key = spoke identifier (e.g., apps, data).
    Value = { name, address_space, subnets }.
  EOT
  type = map(object({
    name          = string
    address_space = string
    subnets = map(object({
      address_prefix = string
    }))
  }))
  default = {}
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic from hub to spokes. Required for Azure Firewall."
  type        = bool
  default     = true
}

variable "use_remote_gateways" {
  description = "Allow spokes to use hub's VPN/ExpressRoute gateways."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
