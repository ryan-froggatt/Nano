# Create an S3 Bucket to host Index.html file

resource "aws_s3_bucket" "nano_s3_bucket" {
  bucket = "${var.s3_bucket_name}"
  acl    = "public-read"
  region = "${var.region}"

  versioning {
    enabled = true
  }
}