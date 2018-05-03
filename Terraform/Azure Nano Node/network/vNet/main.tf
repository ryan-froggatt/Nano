# Create the vNet taking in a variable of the Address Space
resource "azurerm_virtual_network" "nano_vnet" {
  name                = "Nano_vNet"
  resource_group_name = "${var.resource_group}"
  address_space       = ["${var.nano_vnet_cidr}"]
  location            = "${var.az_location}"
}

resource "azurerm_subnet" "nano_subnet" {
  name                 = "Nano_Subnet"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.nano_vnet.name}"
  address_prefix       = "${var.nano_subnet_cidr}"
}
