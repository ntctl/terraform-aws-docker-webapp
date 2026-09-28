terraform {
  backend "s3" {
    bucket = "terraform-state-s3-118755950356-eu-north-1-an"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}
