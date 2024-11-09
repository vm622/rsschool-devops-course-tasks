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

variable "vpc_name" {
  type        = string
  description = "VPC name"
  default     = "my-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = ""
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets"
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets"
  default     = []
}
