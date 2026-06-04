data "aws_ami" "debian" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["debian-13-amd64-*"]
  }
}

data "aws_key_pair" "instance_key" {
  include_public_key = true
  key_name           = aws_key_pair.instance_key.key_name
}

data "aws_availability_zones" "aws_zones" {
  state = "available"
}
