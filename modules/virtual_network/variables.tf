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

variable "subnets" {
  description = "Map of subnets to create. Key = subnet name, Value = address prefix."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
