# ------------------------------------------------------------------------------
# Azure Bastion Module - Input Variables
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Azure Bastion
# ------------------------------------------------------------------------------
variable "name" {
  description = "The name of the Azure Bastion host."
  type        = string
}

variable "location" {
  description = "The location/region where the Azure Bastion host should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure Bastion host."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Azure Bastion host should be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Bastion host."
  type        = string
  default     = "Basic"
}

variable "shareable_link_enabled" {
  description = "Whether to enable shareable link for the Azure Bastion host."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the Azure Bastion host"
  type        = map(string)
  default     = {}
}
