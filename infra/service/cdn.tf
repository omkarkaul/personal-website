resource "aws_cloudfront_distribution" "prefixed_distribution" {
  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = aws_s3_bucket.prefixed_bucket.website_endpoint
    origin_id           = aws_s3_bucket.prefixed_bucket.website_endpoint

    # must include this to avoid invalid DomainName error, not documented anywhere
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_read_timeout    = 30
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  comment = "via Terraform"

  aliases             = ["www.rakmo.io"]
  enabled             = true
  http_version        = "http2"
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  retain_on_delete    = false
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.prefixed_bucket.website_endpoint

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    smooth_streaming       = false
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.website_cert.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "root_distribution" {
  origin {
    domain_name = aws_s3_bucket.root_bucket.website_endpoint
    origin_id   = aws_s3_bucket.root_bucket.bucket

    # must include this to avoid invalid DomainName error, not documented anywhere
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only" # root distro origin policy must be http in order to redirect to https
      origin_ssl_protocols   = ["TLSv1"]
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = aws_s3_bucket.root_bucket.bucket

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.website_cert.arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  comment         = "via Terraform"
  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["rakmo.io"]
}