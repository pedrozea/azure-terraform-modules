# ------------------------------------------------------------------------------
# Azure Firewall Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the Azure Firewall."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the firewall."
  type        = string
}

variable "subnet_id" {
  description = "ID of the AzureFirewallSubnet. Must be /26 or larger."
  type        = string
}

variable "network_rules" {
  description = "List of network rules. Empty list = no rules created."
  type = list(object({
    name                  = string
    source_addresses      = list(string)
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
