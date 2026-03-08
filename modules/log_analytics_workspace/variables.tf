# ------------------------------------------------------------------------------
# Log Analytics Workspace Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the Log Analytics workspace."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the workspace."
  type        = string
}

variable "sku" {
  description = "SKU: PerGB2018 (pay-per-gigabyte) or CapacityReservation."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Data retention in days. Valid range: 30 to 730."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
