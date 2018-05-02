# Create the Nano Subnet
resource "aws_subnet" "nano_subnet" {
  vpc_id     = "${var.nano_vpc_id}"
  cidr_block = "${var.nano_subnet_cidr}"
  availability_zone = "${lookup(var.availability_zone_a, var.region)}"
}