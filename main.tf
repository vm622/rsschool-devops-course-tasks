module "init_state" {
  source              = "./modules/init_state"
  s3_bucket_name      = var.s3_bucket_name
  dynamodb_table_name = var.dynamodb_table_name
}

terraform {
  backend "s3" {
    bucket         = "vm622-rsschool-tf-state"
    key            = "task1.tfstate"
    region         = "eu-central-1" # Frankfurt
    encrypt        = true
    dynamodb_table = "vm622-rsschool-tf-state-lock"
  }
}

module "iam" {
  source                = "./modules/iam"
  tf_dynamodb_locks_arn = module.init_state.tf_dynamodb_locks_arn
}
