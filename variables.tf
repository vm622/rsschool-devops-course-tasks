variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

################################################################
# Terraform state 
################################################################

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table for storing Terraform locks"
  default     = ""
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket for storing Terraform state"
  default     = ""
}

################################################################
# Network
################################################################

variable "admin_ips" {
  type        = list(string)
  description = "A list of admin IPs that may access instances in public subnets"
  default     = ["0.0.0.0/0"]
}
