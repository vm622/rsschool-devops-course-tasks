terraform {
  backend "s3" {
    bucket         = "vm622-rsschool-terraform-state"
    key            = "task1.tfstate"
    region         = "eu-central-1" # Frankfurt
    encrypt        = true
    dynamodb_table = "vm622-rsschool-terraform-state-lock"
  }
}
