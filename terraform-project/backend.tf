terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-0f98f58a"
    key            = "terraform/state.tfstate"
    region         = "us-west-2"
  }
}
