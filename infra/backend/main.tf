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
      key = "personal_website_backend_state.tfstate"
      region = "ap-southeast-2"
      dynamodb_table = "personal-website-backend-state-lock"
      encrypt = true
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_s3_bucket" "terraform_state_bucket" {
    bucket = var.terraform_state_bucket

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
    name = var.terraform_state_lock
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}