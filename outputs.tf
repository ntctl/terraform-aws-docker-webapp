output "aws_ami_debian" {
  description = "AWS Debian Image ID and Name"
  value = [
    data.aws_ami.debian.image_id,
    data.aws_ami.debian.description,
  data.aws_ami.debian.name]
}

output "aws_instance_host_ip" {
  description = "AWS EC2 Instance Hostname and Public IP to connect with via SSH"
  value = [
    aws_instance.terraform_aws_instance.public_ip,
  aws_instance.terraform_aws_instance.private_ip]
}

output "aws_alb_dns_name" {
  description = "AWS Applications Load Balancer DNS Name"
  value       = resource.aws_lb.instance_alb.dns_name
}
