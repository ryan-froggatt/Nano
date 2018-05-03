variable "az_location" {}

variable "resource_group" {}

variable "nano_nsg_id" {}

variable "nano_vnet_cidr" {
  description = "Nano vNet Address Space/CIDR"
  default     = "10.0.0.0/16"
}

variable "nano_subnet_cidr" {
  description = "Nano subnet Address Space/CIDR"
  default     = "10.0.0.0/24"
}
