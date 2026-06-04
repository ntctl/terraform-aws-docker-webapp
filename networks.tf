resource "aws_vpc" "aws_instance_vpc" {
  cidr_block           = local.cidr_block_vpc
  instance_tenancy     = "default"
  enable_dns_hostnames = true
}

resource "aws_subnet" "aws_vpc_subnet" {
  vpc_id                  = aws_vpc.aws_instance_vpc.id
  cidr_block              = local.cidr_block_subnet_a
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.aws_zones.names[0]
}

resource "aws_subnet" "aws_vpc_subnet_b" {
  vpc_id                  = aws_vpc.aws_instance_vpc.id
  cidr_block              = local.cidr_block_subnet_b
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.aws_zones.names[1]
}

resource "aws_default_route_table" "aws_vpc_route" {
  default_route_table_id = aws_vpc.aws_instance_vpc.default_route_table_id

  route {
    cidr_block = local.sg_vpc_allow
    gateway_id = aws_internet_gateway.aws_vpc_gw.id
  }
}

resource "aws_internet_gateway" "aws_vpc_gw" {
  vpc_id = aws_vpc.aws_instance_vpc.id
}

resource "aws_network_interface" "aws_vpc_network" {
  subnet_id               = aws_subnet.aws_vpc_subnet.id
  private_ip_list_enabled = true
  security_groups         = [aws_security_group.vpc_sg_main.id]

  attachment {
    instance     = aws_instance.terraform_aws_instance.id
    device_index = 1
  }
}

resource "aws_security_group" "vpc_sg_main" {
  name        = "sg_allow_ssh_and_tcp"
  description = "Allow 80, 443 and 22 traffic to the AWS EC2 instance"
  vpc_id      = aws_vpc.aws_instance_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "instance_sg_http_rule" {
  security_group_id = aws_security_group.vpc_sg_main.id
  cidr_ipv4         = local.sg_vpc_allow
  ip_protocol       = "tcp"
  from_port         = "80"
  to_port           = "80"
}

resource "aws_vpc_security_group_ingress_rule" "instance_sg_https_rule" {
  security_group_id = aws_security_group.vpc_sg_main.id
  cidr_ipv4         = local.sg_vpc_allow
  ip_protocol       = "tcp"
  from_port         = "443"
  to_port           = "443"
}

resource "aws_vpc_security_group_ingress_rule" "instance_sg_app_rule" {
  security_group_id = aws_security_group.vpc_sg_main.id
  cidr_ipv4         = local.sg_vpc_allow
  ip_protocol       = "tcp"
  from_port         = "8080"
  to_port           = "8080"
}

resource "aws_vpc_security_group_ingress_rule" "instance_sg_ssh_rule" {
  security_group_id = aws_security_group.vpc_sg_main.id
  cidr_ipv4         = var.ssh_ip
  ip_protocol       = "tcp"
  from_port         = "22"
  to_port           = "22"
}

resource "aws_vpc_security_group_egress_rule" "instance_sg_outbound_rule" {
  security_group_id = aws_security_group.vpc_sg_main.id
  cidr_ipv4         = local.sg_vpc_allow
  ip_protocol       = "-1"
}
