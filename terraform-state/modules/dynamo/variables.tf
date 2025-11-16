variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-lock"
}

variable "dynamodb_billing_mode" {
  description = "Billing mode for DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
  default     = "LockID"
}

variable "dynamodb_attribute_name" {
  description = "Attribute name for the DynamoDB table"
  type        = string
  default     = "LockID"
}

variable "dynamodb_attribute_type" {
  description = "Attribute type for the DynamoDB table"
  type        = string
  default     = "S"
}
