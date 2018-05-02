output "nano_public_ip" {
  value = "${aws_instance.nano_instance.public_ip}"
}
