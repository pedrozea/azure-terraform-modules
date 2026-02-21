# ------------------------------------------------------------------------------
# Virtual Network Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy the virtual network in."
  type        = string
}

variable "location" {
  description = "Azure region for the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network (e.g., ['10.0.0.0/16'])."
  type        = list(string)
}

variable "dns_servers" {
  description = "List of DNS server IP addresses for the virtual network."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = <<-EOT
    Map of subnets to create.
    Key = subnet name.
    Value = object with address_prefix and optional delegation settings.
    Set delegation_name to empty string or omit for standard subnets.
  EOT
  type = map(object({
    address_prefix     = string
    delegation_name    = optional(string)
    delegation_service = optional(string, "Microsoft.Network/networkInterfaces")
    delegation_actions = optional(list(string), ["Microsoft.Network/networkInterfaces/*"])
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
