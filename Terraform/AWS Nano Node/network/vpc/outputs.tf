output "nano_vpc_id" {
  value = "${aws_vpc.nano_vpc.id}"
}

output "nano_igw_id" {
  value = "${aws_internet_gateway.nano_igw.id}"
}