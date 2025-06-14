terraform {
}


module "backend_state" {
  source                         = "./modules/backend_state"
  terraform_state_s3_bucket_name = var.terraform_state_s3_bucket_name
}
