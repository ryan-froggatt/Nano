output "nano_public_ip" {
  value = "${azurerm_public_ip.nano_public_ip.ip_address}"
}
