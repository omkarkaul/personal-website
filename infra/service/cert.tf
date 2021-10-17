resource "aws_acm_certificate" "website_cert" {
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