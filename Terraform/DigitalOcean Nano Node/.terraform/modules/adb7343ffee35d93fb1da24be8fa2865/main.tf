#Create the UserData Template File
data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.sh")}"
}

#Create the Nano Droplet
resource "digitalocean_droplet" "nano_node" {
  image  = "ubuntu-14-04-x64"
  name   = "${var.name}"
  region = "${var.region}"
  size   = "1gb"
  user_data = "${data.template_file.user_data.rendered}"
}

