variable "nano_instance_name" {
  description = "Nano Node Host Name"
  default     = "Nano_Node"
}

variable "key_name" {
  description = "Name of the EC2 keypair to use in AWS."
  default     = "Nano"
}

variable "nano_ami_id" {
  description = "AWS Linux Ubuntu 16.04 AMI Id"
  type = "map"
  default = {
        "eu-west-1" = "ami-f90a4880"
        "eu-west-2" = "ami-f4f21593"
        "eu-west-3" = "ami-0e55e373"
        "eu-central-1" = "ami-7c412f13"
        "us-west-1" = "ami-925144f2"
        "us-west-2" = "ami-4e79ed36"
        "us-east-1" = "ami-43a15f3e"
        "us-east-2" = "ami-916f59f4"
        "ca-central-1" = "ami-ae55d2ca"
    }
}

variable "instance_type" {
  description = "AWS Instance Size"
  default     = "t2.micro"
}

variable "nano_sg_id" {}
variable "nano_subnet_id" {}
variable "region" {}
variable "nano_vpc_id" {}
