# Specify the provider and access details - By Default this uses AWS CLI Credentials if none are specified
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "/path/to/credentials/file"
  profile                 = "terraform"
}

# Create modules in line with local folder structure
module "vpc" {
  source = "./network/vpc"
}

module "subnets" {
  source = "./network/subnets"
  nano_vpc_id = "${module.vpc.nano_vpc_id}"
  region = "${var.aws_region}"
}

module "routing_tables" {
  source = "./network/routing_tables"
  nano_subnet_id = "${module.subnets.nano_subnet_id}"
  nano_vpc_id = "${module.vpc.nano_vpc_id}"
  nano_igw_id = "${module.vpc.nano_igw_id}"
}

module "security_groups" {
  source = "./network/security_groups"
  nano_vpc_id = "${module.vpc.nano_vpc_id}"
}

module "instances" {
  source = "./instances"
  nano_sg_id = "${module.security_groups.nano_sg_id}"
  nano_subnet_id = "${module.subnets.nano_subnet_id}"
  nano_vpc_id = "${module.vpc.nano_vpc_id}"
  region = "${var.aws_region}"
}