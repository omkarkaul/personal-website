terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket         = "personal-website-state-bucket"
    key            = "personal_website_state.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "personal-website-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_s3_bucket" "root_bucket" {
  bucket = lookup(var.website_bucket, "root")

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    redirect_all_requests_to = "https://${aws_s3_bucket.prefixed_bucket.bucket}"
  }
}

resource "aws_s3_bucket" "prefixed_bucket" {
  bucket = lookup(var.website_bucket, "prefixed")

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  acl    = "public-read"
  policy = file("prefixed_bucket_policy.json")

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "root_bucket_public_access" {
  bucket                  = aws_s3_bucket.root_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "service_state_lock" {
  name         = var.service_state_lock
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}