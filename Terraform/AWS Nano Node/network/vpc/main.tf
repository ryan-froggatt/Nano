# Create the VPC taking in a variable of the CIDR range
resource "aws_vpc" "nano_vpc" {
  cidr_block = "${var.nano_vpc_cidr}"
}

# Create an Internet Gateway within the Main VPC
resource "aws_internet_gateway" "nano_igw" {
  vpc_id = "${aws_vpc.nano_vpc.id}"

  tags {
    Name = "nano_igw"
  }
}