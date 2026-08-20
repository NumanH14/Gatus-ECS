resource "aws_s3_bucket" "numan-terraform-bootstrap-state" {
  bucket = var.bucket
  tags = {
  name = var.bucket-tag
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.numan-terraform-bootstrap-state.id
  policy = templatefile("${path.module}/policies/bucketpolicy.json", {
  organisation_id = var.organisation_id
})
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.numan-terraform-bootstrap-state.id
  versioning_configuration {
  status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block-public_access" {
  bucket = aws_s3_bucket.numan-terraform-bootstrap-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt tf state file"
  enable_key_rotation     = true
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "mykey" {
  name          = var.kms-alias
  target_key_id = aws_kms_key.mykey.arn
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse-encryption" {
  bucket = aws_s3_bucket.numan-terraform-bootstrap-state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled       = true
    blocked_encryption_types = ["NONE"]
  }
}

resource "aws_kms_key_policy" "kms_policy" {
  key_id = aws_kms_key.mykey.id
  policy = templatefile("${path.module}/policies/kmspolicy.json", {
  admin_role_arn = var.admin_role_arn
  key_user       = var.key_user
})
}

