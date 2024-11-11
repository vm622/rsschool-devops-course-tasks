aws_region = "eu-central-1"

s3_bucket_name      = "vm622-rsschool-tf-state"
dynamodb_table_name = "vm622-rsschool-tf-state-lock"

private_inbound_acl_rules = [
  {
    rule_number = 1
    cidr_block  = "0.0.0.0/0"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    rule_action = "allow"
  }
]
