terraform {
  backend "s3" {
    bucket  = "tfstate-fiap-alex-academy-rds"
    key     = "rds-cliente/terraform.tfstate"
    region  = "us-east-1"
    encrypt = false
  }
}
