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

variable "public_route_table_list" {
  description = "Route table for public subnets"
  type        = list(map(string))
  default     = []
}

variable "private_route_table_list" {
  description = "Route table for private subnets"
  type        = list(map(string))
  default     = []
}


variable "public_inbound_acl_rules" {
  description = "Public subnets inbound network ACL rules"
  type        = list(map(string))
  default     = []
}

variable "public_outbound_acl_rules" {
  description = "Public subnets outbound network ACL rules"
  type        = list(map(string))
  default     = []
}

variable "private_inbound_acl_rules" {
  description = "Private subnets inbound network ACL rules"
  type        = list(map(string))
  default     = []
}


variable "private_outbound_acl_rules" {
  description = "Private subnets outbound network ACL rules"
  type        = list(map(string))
  default     = []
}

variable "one_natgw_per_az" {
  type        = bool
  description = "Create one NAT gateway per AZ"
  default     = true
}

variable "admin_ips" {
  type        = list(string)
  description = "A list of admin IPs that may access instances in public subnets"
}

variable "public_sg_inbound" {
  description = "Security group inbound rules for public instance"
  type        = list(map(string))
  default     = []
}

variable "public_sg_outbound" {
  description = "Security group outbound rules for public instance"
  type        = list(map(string))
  default     = []
}

variable "private_sg_inbound" {
  description = "Security group inbound rules for private instance"
  type        = list(map(string))
  default     = []
}

variable "private_sg_outbound" {
  description = "Security group outbound rules for private instance"
  type        = list(map(string))
  default     = []
}
