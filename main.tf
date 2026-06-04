resource "aws_instance" "terraform_aws_instance" {
  ami                         = data.aws_ami.debian.id
  instance_type               = local.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.instance_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_ecr_pulls.name
  vpc_security_group_ids      = [aws_security_group.vpc_sg_main.id]
  subnet_id                   = aws_subnet.aws_vpc_subnet.id
  depends_on                  = [aws_internet_gateway.aws_vpc_gw]

  user_data = file("docker-install.sh")
}

resource "aws_key_pair" "instance_key" {
  public_key = var.public_key
}

resource "aws_ecr_repository" "ecr" {
  name = var.name

  encryption_configuration {
    encryption_type = "KMS"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}