variable "nano_vpc_id" {}

variable "nano_subnet_cidr" {
  description = "Nano Subnet CIDR"
  default     = "10.0.0.0/24"
}

variable "region" {}

variable "availability_zone_a" {
    description = "Availability Zone Map A"
    type = "map"
    default = {
        "eu-west-1" = "eu-west-1a"
        "eu-west-2" = "eu-west-2a"
        "eu-west-3" = "eu-west-3a"
        "eu-central-1" = "eu-central-1a"
        "us-west-1" = "us-west-1a"
        "us-west-2" = "us-west-2a"
        "us-east-1" = "us-east-1a"
        "us-east-2" = "us-east-2a"
        "ca-central-1" = "ca-central-1a"
    }
}