#Create the Nano Instance Public IP Address
resource "azurerm_public_ip" "nano_public_ip" {
  name                         = "${format("${var.vm_name}-pip")}"
  location                     = "${var.az_location}"
  resource_group_name          = "${var.resource_group}"
  public_ip_address_allocation = "static"
}

#Create the Nano Instance Network Interface
resource "azurerm_network_interface" "nano_vm_nic" {
  name                      = "${format("${var.vm_name}-nic")}"
  location                  = "${var.az_location}"
  resource_group_name       = "${var.resource_group}"
  network_security_group_id = "${var.nano_nsg_id}"

  ip_configuration {
    name                          = "IP_Configuration"
    subnet_id                     = "${var.nano_subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.nano_public_ip.id}"
  }
}

#Create the Nano Instance
resource "azurerm_virtual_machine" "nano_vm" {
  name                  = "${var.vm_name}"
  location              = "${var.az_location}"
  resource_group_name   = "${var.resource_group}"
  network_interface_ids = ["${azurerm_network_interface.nano_vm_nic.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "Nano_OS_Disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.vm_name}"
    admin_username = "${var.vm_user}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

#Create the Nano Virtual Machine Extension
resource "azurerm_virtual_machine_extension" "nano_vm_extension" {
  name                 = "NanoNodeInstall"
  location             = "${var.az_location}"
  resource_group_name  = "${var.resource_group}"
  virtual_machine_name = "${azurerm_virtual_machine.nano_vm.name}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
      {
        "fileUris": ["https://raw.githubusercontent.com/ryan-froggatt/Nano/master/NanoNodeInstall.sh"],
        "commandToExecute": "sh NanoNodeInstall.sh"
      }
  SETTINGS
}
