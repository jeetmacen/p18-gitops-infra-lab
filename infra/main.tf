terraform {
  required_version = ">= 1.10, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.100.0"
    }
  }

  backend "s3" {
    key          = "terraform/p18.tfstate"
    use_lockfile = true
  }
}

variable "bucket_name" {
  type        = string
  description = "Existing private S3 bucket for this lab."
}

resource "aws_s3_object" "page" {
  bucket       = var.bucket_name
  key          = "index.html"
  source       = "${path.module}/index.html"
  source_hash  = filemd5("${path.module}/index.html")
  content_type = "text/html"
}
