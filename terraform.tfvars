aws_region = "eu-central-1"

s3_bucket_name      = "vm622-rsschool-tf-state"
dynamodb_table_name = "vm622-rsschool-tf-state-lock"

vpc_name        = "My VPC"
vpc_cidr        = "10.0.0.0/22"
public_subnets  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]

subnets_acl = {
  "public" = {
    "allow-all-egress" = {
      rule_number = 100
      egress      = true
      cidr_block  = "0.0.0.0/0"
      protocol    = "all"
      from_port   = -1
      to_port     = -1
      rule_action = "allow"
    },
    "allow-all-ingress" = {
      rule_number = 100
      egress      = false
      cidr_block  = "0.0.0.0/0"
      protocol    = "all"
      from_port   = -1
      to_port     = -1
      rule_action = "allow"
    }
  },
  "private" = {
    "allow-all-egress" = {
      rule_number = 100
      egress      = true
      cidr_block  = "0.0.0.0/0"
      protocol    = "all"
      from_port   = -1
      to_port     = -1
      rule_action = "allow"
    },
    "allow-ssh-ingress" = {
      rule_number = 1
      egress      = false
      cidr_block  = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      rule_action = "allow"
    }
  }
}
