# ------------------------------------------------------------------------------
# Network Security Group Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the network security group."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the NSG."
  type        = string
}

variable "security_rules" {
  description = <<-EOT
    Map of security rules. Key = rule name, value = rule parameters.
    direction: Inbound | Outbound
    access: Allow | Deny
    protocol: Tcp | Udp | Icmp | *
  EOT
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string, "*")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
    description                = optional(string)
  }))
  default = {}
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate this NSG with."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
