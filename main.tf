provider "aws" {
  region = "eu-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
module "s3" {
  source = "./modules/s3"
  s3_bucket_name = "my-terraform-state-bucket"
}


