variable "az_location" {}
variable "resource_group" {}
variable "nano_vnet_id" {}
variable "nano_subnet_id" {}
variable "nano_nsg_id" {}

variable "vm_name" {
  description = "Nano Node Host Name"
  default     = "NanoNode"
}

variable "vm_size" {
  description = "Nano Virtual Machine Size"
  default     = "Standard_D2s_v3"
}

variable "vm_user" {
  description = "Admin username for Nano Virtual Machine"
  default     = "nano-user"
}

variable "vm_password" {
  description = "Password for Admin User"
  default     = "PleaseSetPassword1"
}
