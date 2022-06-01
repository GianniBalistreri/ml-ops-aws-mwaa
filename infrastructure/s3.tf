# S3 Bucket: Airflow (MWAA)
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.prefix
  count         = var.s3_create ? 1 : 0
  tags          = var.s3_tags
  force_destroy = var.s3_force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = var.s3_versioning_enabled
  }
  #tags = merge(local.tags, {
  #  Name = var.prefix
  #})
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "dags" {
  for_each = fileset("dags/", "*.py")
  bucket   = aws_s3_bucket.s3_bucket.id
  key      = "dags/${each.value}"
  source   = "dags/${each.value}"
  etag     = filemd5("dags/${each.value}")
}

# S3 Bucket: Model
resource "aws_s3_bucket" "model" {
  bucket        = var.s3_bucket_name_model
  count         = var.s3_create ? 1 : 0
  tags          = var.s3_tags
  force_destroy = var.s3_force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = var.s3_versioning_enabled
  }
}

# S3 Bucket: Data for Prediction
resource "aws_s3_bucket" "data_for_prediction" {
  bucket        = var.s3_bucket_name_data_for_prediction
  count         = var.s3_create ? 1 : 0
  tags          = var.s3_tags
  force_destroy = var.s3_force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = var.s3_versioning_enabled
  }
}

# S3 Bucket: Inference
resource "aws_s3_bucket" "inference" {
  bucket        = var.s3_bucket_name_inference
  count         = var.s3_create ? 1 : 0
  tags          = var.s3_tags
  force_destroy = var.s3_force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = var.s3_versioning_enabled
  }
}

# S3 Bucket: Training
resource "aws_s3_bucket" "training" {
  bucket        = var.s3_bucket_name_training
  count         = var.s3_create ? 1 : 0
  tags          = var.s3_tags
  force_destroy = var.s3_force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = var.s3_versioning_enabled
  }
}
