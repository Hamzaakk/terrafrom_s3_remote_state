variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

