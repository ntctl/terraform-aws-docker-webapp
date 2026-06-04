variable "region" {
  description = "AWS account region"
  type        = string
  default     = "eu-north-1"
}

variable "id" {
  description = "AWS account ID"
  type        = string
  sensitive   = true
}

variable "name" {
  description = "AWS ECR repository name"
  type        = string
  default     = "docker_images"
}

variable "aws_access_key_id" {
  description = "AWS access key"
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  sensitive   = true
}

variable "public_key" {
  description = "SSH public key linked to AWS EC2 instance"
  sensitive   = true
}

variable "ssh_ip" {
  sensitive   = true
  description = "The only IP address to connect to the AWS EC2 instance"
}

variable "key_name" {
  description = "AWS EC2 SSH key name"
  default     = "terraform-aws-instance-key"
  type        = string
}
