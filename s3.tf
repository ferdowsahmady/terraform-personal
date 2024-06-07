resource "aws_s3_bucket" "ziyotek_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = var.bucket_force_destroy
  tags          = var.s3_tag
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.ziyotek_bucket.id
  versioning_configuration {
    status = var.aws_s3_bucket_versioning
  }
}

resource "aws_s3_bucket_object_lock_configuration" "ziyotek_bucket" {
  bucket              = aws_s3_bucket.ziyotek_bucket.id
  object_lock_enabled = var.s3_bucket_object_lock

  rule {
    default_retention {
      mode = var.object_lock_mode
      days = var.default_retention_days
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.ziyotek_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.ziyotek_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_acl" "ziyotek_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.public-access,
  ]
  bucket = aws_s3_bucket.ziyotek_bucket.id
  acl    = var.s3_bucket_acl
}


resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.ziyotek_bucket.id
  rule {
    object_ownership = var.s3_bucket_ownership_controls
  }
}