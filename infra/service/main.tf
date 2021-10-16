terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
      bucket = "personal-website-state-bucket"
      key = "personal_website_state.tfstate"
      region = "ap-southeast-2"
      dynamodb_table = "personal-website-state-lock"
      encrypt = true
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
}

resource "aws_dynamodb_table" "service_state_lock" {
    name = var.service_state_lock
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}