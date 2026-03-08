# ------------------------------------------------------------------------------
# Virtual Machine Module - Input Variables
# ------------------------------------------------------------------------------

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the VMs."
  type        = string
}

variable "vms" {
  description = <<-EOT
    Map of VMs to create. Key = VM name, value = VM configuration.
    os_type: "linux" | "windows"
    For Linux: ssh_public_key required.
    For Windows: admin_password required.
  EOT
  type = map(object({
    subnet_id          = string
    size               = string
    os_type            = string
    admin_username     = string
    admin_password     = optional(string)
    ssh_public_key     = optional(string)
    private_ip_address = optional(string)
    create_public_ip   = optional(bool, false)
    os_disk_type       = optional(string, "Standard_LRS")
    os_disk_size_gb    = optional(number, 64)
    image_publisher    = optional(string, "Canonical")
    image_offer        = optional(string, "0001-com-ubuntu-server-jammy")
    image_sku          = optional(string, "22_04-lts")
    image_version      = optional(string, "latest")
  }))
}

variable "boot_diagnostics_storage_uri" {
  description = "Storage account URI for boot diagnostics. Set to null to disable."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
