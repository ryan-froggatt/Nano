output "nano_vnet_id" {
  value = "${azurerm_virtual_network.nano_vnet.id}"
}

output "nano_subnet_id" {
  value = "${azurerm_subnet.nano_subnet.id}"
}
