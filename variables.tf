variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = ""
}

variable "terraform_state_s3_bucket_name" {
  type        = string
  description = "S3 bucket name for Terraform state"
  default     = ""
}
