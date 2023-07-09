resource "aws_s3_bucket" "my_bucket" {
  bucket = local.s3_suffix
}
