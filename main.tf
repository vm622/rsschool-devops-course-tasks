terraform {
  backend "s3" {
    bucket       = ""
    key          = ""
    region       = ""
    encrypt      = true
    use_lockfile = true
  }
}

module "backend_state" {
  source                         = "./modules/backend_state"
  terraform_state_s3_bucket_name = var.terraform_state_s3_bucket_name
}

module "iam" {
  source = "./modules/iam"
}
