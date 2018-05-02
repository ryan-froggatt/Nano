#Create the UserData Template File
data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.sh")}"
}

#Create the Nano Instance using variables
resource "aws_instance" "nano_instance" {
  instance_type = "${var.instance_type}"
  ami           = "${lookup(var.nano_ami_id, var.region)}"
  subnet_id = "${var.nano_subnet_id}"
  key_name = "${var.key_name}"
  security_groups = ["${var.nano_sg_id}"]
  associate_public_ip_address = true
  user_data = "${data.template_file.user_data.rendered}"

  tags = {
      Name = "${var.nano_instance_name}"
  }
}