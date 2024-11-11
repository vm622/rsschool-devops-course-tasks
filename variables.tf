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

variable "subnets_acl" {
  type = map(map(object({
    rule_number = number
    egress      = bool
    cidr_block  = string
    protocol    = string
    from_port   = number
    to_port     = number
    rule_action = string
  })))
  default = {}
}
