terraform {
  backend "s3" {
    bucket  = "tfstate-fiap-alex-academy-rds-1"
    key     = "rds-catalogo/terraform.tfstate"
    region  = "us-east-1"
    encrypt = false
  }
}
