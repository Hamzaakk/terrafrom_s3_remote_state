resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.s3_bucket_name}-${random_id.suffix.hex}"
}
resource "random_id" "suffix" {
  byte_length = 4
}