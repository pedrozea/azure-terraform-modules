# ------------------------------------------------------------------------------
# Network Security Group Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the Network Security Group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "security_rules" {
  description = "List of security rules for the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string # Inbound o Outbound
    access                     = string # Allow o Deny
    protocol                   = string # Tcp, Udp, Icmp, o *
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}
