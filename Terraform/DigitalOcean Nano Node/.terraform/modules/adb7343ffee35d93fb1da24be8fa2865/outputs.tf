output "droplet_public_ip" {
  value = "${digitalocean_droplet.nano_node.ipv4_address}"
}