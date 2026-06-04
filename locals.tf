locals {
  instance_type = "t3.micro"
}

locals {
  cidr_block_vpc = "172.30.0.0/16"
}

locals {
  cidr_block_subnet_a = "172.30.0.0/17"
}

locals {
  cidr_block_subnet_b = "172.30.128.0/17"
}

locals {
  sg_vpc_allow = "0.0.0.0/0"
}