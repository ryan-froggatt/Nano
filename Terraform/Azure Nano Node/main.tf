# Specify the provider and access details - By Default this uses AWS CLI Credentials if none are specified
provider "azurerm" {}

# Create a resource group
resource "azurerm_resource_group" "nano_rg" {
  name     = "Nano_Test"
  location = "${var.az_location}"
}

# Create modules in line with local folder structure
module "vNet" {
  source         = "./network/vNet"
  az_location    = "${var.az_location}"
  resource_group = "${azurerm_resource_group.nano_rg.name}"
  nano_nsg_id    = "${module.security_groups.nano_nsg_id}"
}

module "security_groups" {
  source         = "./network/security_groups"
  az_location    = "${var.az_location}"
  resource_group = "${azurerm_resource_group.nano_rg.name}"
}

module "virtual_machines" {
  source         = "./virtual_machines"
  az_location    = "${var.az_location}"
  resource_group = "${azurerm_resource_group.nano_rg.name}"
  nano_vnet_id   = "${module.vNet.nano_vnet_id}"
  nano_subnet_id = "${module.vNet.nano_subnet_id}"
  nano_nsg_id    = "${module.security_groups.nano_nsg_id}"
}
