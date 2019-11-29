variable "resource_name" {}
variable "bucket_name" {}
variable "region" {}
variable "error_page" {}
variable "ssl_arn" {}

variable "route53" {
   type = map
# Expects:
#  zone_id  = "existing route 53 zone"
#  a        = "A record to add to zone"
#  cname    = "CNAME that will point to the A record"
}

#
# s3 bucket
#
resource "aws_s3_bucket" "web_bucket" {

   bucket = var.bucket_name
   force_destroy = true
   acl = "public-read"
   tags = {
         layer = "terraform"
	}
   policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[{
    "Sid":"PublicReadForGetBucketObjects",
        "Effect":"Allow",
      "Principal": "*",
      "Action":"s3:GetObject",
      "Resource":["arn:aws:s3:::${var.bucket_name}/*"
      ]
    }
  ]
}
POLICY
  
   website {
      index_document = "index.html"
      error_document = var.error_page
   }
}


#
# Cloudfront CDN
#
resource "aws_cloudfront_distribution" "web_bucket" {
	tags = {
		layer = "terraform"
	}
    origin {
        custom_origin_config = {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "http-only"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
            origin_read_timeout = 60
        }

# This is the DNS name of the bucket and the bucket's id
        domain_name = "${aws_s3_bucket.web_bucket.id}.s3-website.${var.region}.amazonaws.com"
        origin_id   = aws_s3_bucket.web_bucket.id
    }

# TODO add ssl cert
    viewer_certificate {
        #cloudfront_default_certificate = true
        acm_certificate_arn = var.ssl_arn
        ssl_support_method = "sni-only"
        minimum_protocol_version = "TLSv1"
    }

    enabled = true
    is_ipv6_enabled = true
    default_root_object = "index.html"

# These must match route53 records
    aliases = [ var.route53["cloud_a1"], var.route53["cloud_a2"]]

    custom_error_response {
       error_code         = 404
       response_code      = 200
       response_page_path = var.error_page
    }

    http_version = "http2"

    default_cache_behavior {
        allowed_methods  = ["HEAD", "GET", "OPTIONS"]
        cached_methods  = ["HEAD", "GET", "OPTIONS"]
        target_origin_id = aws_s3_bucket.web_bucket.id

        forwarded_values {
          query_string = false

          cookies {
            forward = "none"
          }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    price_class = "PriceClass_All"

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

}

#
# Route53 cloudfront DNS
#
resource "aws_route53_record" "root4" {
   zone_id = var.route53["zone_id"]
   name    = var.route53["cloud_a1"]
   type    = "A"

   alias {
     name    = aws_cloudfront_distribution.web_bucket.domain_name
     zone_id = "Z2FDTNDATAQYW2"
     evaluate_target_health = false
   }
}
resource "aws_route53_record" "root6" {
   zone_id = var.route53["zone_id"]
   name    = var.route53["cloud_a1"]
   type    = "AAAA"

   alias {
     name    = aws_cloudfront_distribution.web_bucket.domain_name
     zone_id = "Z2FDTNDATAQYW2"
     evaluate_target_health = false
   }
}

resource "aws_route53_record" "www4" {
   zone_id = var.route53["zone_id"]
   name    = var.route53["cloud_a2"]
   type    = "A"

   alias {
     name    = aws_cloudfront_distribution.web_bucket.domain_name
     zone_id = "Z2FDTNDATAQYW2"
     evaluate_target_health = false
   }
}
resource "aws_route53_record" "www6" {
   zone_id = var.route53["zone_id"]
   name    = var.route53["cloud_a2"]
   type    = "AAAA"

   alias {
     name    = aws_cloudfront_distribution.web_bucket.domain_name
     zone_id = "Z2FDTNDATAQYW2"
     evaluate_target_health = false
   }
}
