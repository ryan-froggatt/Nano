# Bastion Security Group to provide access to Bastion Hosts
resource "azurerm_network_security_group" "nano_nsg" {
  name                = "Nano_NSG"
  location            = "${var.az_location}"
  resource_group_name = "${var.resource_group}"

  # HTTP access from anywhere
  security_rule {
    name                       = "HTTP_ANY"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  # SSH access from anywhere
  security_rule {
    name                       = "SSH_ANY"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
