# https://docs.aws.amazon.com/acm/latest/userguide/acm-services.html
# "To use an ACM Certificate with CloudFront, you must request or import the certificate in the US East (N. Virginia) region."
# https://www.terraform.io/docs/configuration/providers.html#multiple-provider-instances

provider "aws" {
  alias      = "acm_provider"
  region     = "us-east-1"
}

resource "aws_acm_certificate" "website_cert" {
  provider          = aws.acm_provider
  domain_name       = "www.rakmo.io"
  validation_method = "DNS"
  subject_alternative_names = ["rakmo.io"]

  lifecycle {
      create_before_destroy = true
  }
}

locals {
  cert_dvo = tolist(aws_acm_certificate.website_cert.domain_validation_options)
}