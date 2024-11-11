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
  description = "Route table for public subnets"
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = {}
}

variable "private_route_table_map" {
  description = "Route table for private subnets"
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = {}
}

variable "subnets_acl" {
  description = "Network ACL list for subnets"
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
