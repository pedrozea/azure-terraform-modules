# ------------------------------------------------------------------------------
# Simple Network Example - Input Variables
# ------------------------------------------------------------------------------

variable "environment" {
  description = "Environment name (e.g., dev, lab)."
  type        = string
  default     = "lab"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "eastus"
}
