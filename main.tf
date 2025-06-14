terraform {
  backend "s3" {
    bucket       = "vm622-rsschool-devops-2025q2-terraform-state"
    key          = "rsschool-devops-tf-state.tfstate"
    region       = "us-east-1"
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
