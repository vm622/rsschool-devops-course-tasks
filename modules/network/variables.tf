variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

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

variable "public_route_table_map" {
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = {}
}

variable "private_route_table_map" {
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = {}
}
