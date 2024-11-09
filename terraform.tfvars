aws_region          = "eu-central-1"

s3_bucket_name      = "vm622-rsschool-tf-state"
dynamodb_table_name = "vm622-rsschool-tf-state-lock"

vpc_name = "My VPC"
vpc_cidr = "10.0.0.0/22"
public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
