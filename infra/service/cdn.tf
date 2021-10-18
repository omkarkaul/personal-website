resource "aws_cloudfront_distribution" "prefixed_distribution" {
    origin {
        domain_name = aws_s3_bucket.prefixed_bucket.website_endpoint
        origin_id = aws_s3_bucket.prefixed_bucket.bucket

        # must include this to avoid invalid DomainName error, not documented anywhere
        custom_origin_config {
            http_port              = "80"
            https_port             = "443"
            origin_protocol_policy = "https-only" # prefixed distro origin policy must be https
            origin_ssl_protocols   = ["TLSv1"]
        }
    }
    

    default_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        allowed_methods = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.prefixed_bucket.bucket

        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }

        min_ttl                = 0
        default_ttl            = 86400
        max_ttl                = 31536000
    }

    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.website_cert.arn
        ssl_support_method = "sni-only"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    comment = "via Terraform"
    enabled = true
    is_ipv6_enabled = true
    aliases = ["www.rakmo.io"]
    default_root_object = "index.html"
}

resource "aws_cloudfront_distribution" "root_distribution" {
    origin {
        domain_name = aws_s3_bucket.root_bucket.website_endpoint
        origin_id = aws_s3_bucket.root_bucket.bucket

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
        allowed_methods = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.root_bucket.bucket

        forwarded_values {
            query_string = true
            cookies {
                forward = "all"
            }
        }
    }

    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.website_cert.arn
        ssl_support_method = "sni-only"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    comment = "via Terraform"
    enabled = true
    is_ipv6_enabled = true
    aliases = ["rakmo.io"]
    default_root_object = "index.html"
}