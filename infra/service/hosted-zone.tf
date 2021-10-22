resource "aws_route53_zone" "website" {
  name    = lookup(var.website_bucket, "root")
  comment = "via Terraform"
}

resource "aws_route53_record" "main_record" {
  zone_id = aws_route53_zone.website.zone_id
  name    = lookup(var.website_bucket, "prefixed")
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.prefixed_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.prefixed_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root_to_prefix_record" {
  zone_id = aws_route53_zone.website.zone_id
  name    = lookup(var.website_bucket, "root")
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "website_cert_record" {
  name    = local.cert_dvo.0.resource_record_name
  type    = local.cert_dvo.0.resource_record_type
  zone_id = aws_route53_zone.website.zone_id
  records = [local.cert_dvo.0.resource_record_value]
  ttl     = "60"
}

resource "aws_route53_record" "website_cert_record2" {
  name    = local.cert_dvo.1.resource_record_name
  type    = local.cert_dvo.1.resource_record_type
  zone_id = aws_route53_zone.website.zone_id
  records = [local.cert_dvo.1.resource_record_value]
  ttl     = "60"
}