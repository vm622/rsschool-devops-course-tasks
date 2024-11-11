aws_region = "eu-central-1"

s3_bucket_name      = "vm622-rsschool-tf-state"
dynamodb_table_name = "vm622-rsschool-tf-state-lock"

subnets_acl = {
  "public" = {
    "allow-all-outbound" = {
      rule_number = 100
      egress      = true
      cidr_block  = "0.0.0.0/0"
      protocol    = "all"
      from_port   = -1
      to_port     = -1
      rule_action = "allow"
    },
    "allow-all-inbound" = {
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
    "allow-all-inbound" = {
      rule_number = 100
      egress      = true
      cidr_block  = "0.0.0.0/0"
      protocol    = "all"
      from_port   = -1
      to_port     = -1
      rule_action = "allow"
    },
    "allow-ssh-outbound" = {
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
