provider "aws" {
  region = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  tag = "state_lab"
}