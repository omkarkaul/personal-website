terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket         = "aws-admin-tf-bucket"
    key            = "aws-admin-tf-bucket.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "aws-admin-tf-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  profile = "personal"
  region  = var.region
}

resource "aws_s3_bucket" "qna_bucket" {
  bucket = "rakmo-bucket"
}

resource "aws_s3_bucket_versioning" "qna_bucket_versioning" {
  bucket = aws_s3_bucket.qna_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.qna_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["HEAD", "GET"]
    allowed_origins = [
      "https://www.rakmo.io",
      "https://rakmo.io",
      "http://localhost:3000",
      "https://*rakmo.netlify.app"
    ]
  }
}

resource "aws_s3_bucket_policy" "restrict_qna_bucket_access" {
  bucket = aws_s3_bucket.qna_bucket.id
  policy = data.aws_iam_policy_document.restrict_qna_bucket_access.json
}

data "aws_iam_policy_document" "restrict_qna_bucket_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::134054802350:user/personal_website_user"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.qna_bucket.arn,
      "${aws_s3_bucket.qna_bucket.arn}/*",
    ]
  }
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::134054802350:user/GlobalAdmin"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.qna_bucket.arn,
      "${aws_s3_bucket.qna_bucket.arn}/*",
    ]
  }
}
