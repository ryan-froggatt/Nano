#Create Routing Table for Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = "${var.nano_vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.nano_igw_id}"
  }
}

#Create Route Table Associations for each of the Private an Public Subnets
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id = "${var.nano_subnet_id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

