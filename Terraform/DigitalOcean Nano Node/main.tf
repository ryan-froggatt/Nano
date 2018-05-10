# Specify the provider and access details - By Default this uses AWS CLI Credentials if none are specified
provider "digitalocean" {
  token = "${var.do_token}"
}
# Create modules in line with local folder structure
module "droplet" {
  source         = "./droplet"
  name   = "${var.droplet_name}"
  region = "${var.region}"
}
