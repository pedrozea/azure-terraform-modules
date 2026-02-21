# ------------------------------------------------------------------------------
# Lab Complete Example - Input Variables
# ------------------------------------------------------------------------------

variable "environment" {
  description = "Environment name (e.g., dev, lab, prod)."
  type        = string
  default     = "lab"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
