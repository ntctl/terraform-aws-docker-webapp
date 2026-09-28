resource "aws_s3_bucket" "aws_tf_storage" {
  bucket           = var.s3_bucket_name
  bucket_namespace = "account-regional"
  force_destroy    = false
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.aws_tf_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "versioning_bucket_acl" {
  bucket = aws_s3_bucket.aws_tf_storage.id
  acl    = "private"
}
