# ------------------------------------------------------------------------------
# Azure Linux VM Module - Input Variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name of the Linux VM"
  type        = string
}

variable "location" {
  description = "Location where the VM will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "public_key" {
  description = "Public key for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}
