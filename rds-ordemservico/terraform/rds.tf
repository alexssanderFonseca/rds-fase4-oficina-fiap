provider "aws" {
  region = "us-east-1"
}

resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "rds_password_secret" {
  name        = "rds-ordemservico/${aws_db_instance.academico_rds.identifier}/password"
  description = "RDS Ordemservico password for ${aws_db_instance.academico_rds.identifier}"

  tags = {
    Name        = "rds-ordemservico-password"
    Environment = "ordemservico"
    ManagedBy   = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "rds_password_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_password_secret.id
  secret_string = random_password.rds_password.result
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-ordemservico-oficina-subnet-group"
  subnet_ids = local.private_subnets
  tags = {
    Name        = "RDS Ordemservico Oficina Subnet Group"
    Environment = "ordemservico"
  }
}

resource "aws_db_instance" "academico_rds" {
  identifier            = "ordemservico-oficina-rds"
  engine                = "postgres"
  engine_version        = "18"
  instance_class        = "db.t3.micro"
  allocated_storage     = 5
  max_allocated_storage = 0
  storage_type          = "gp2"
  storage_encrypted     = false
  db_name               = "ordemservicodb"
  username              = "userOrdemservicoDb"
  password              = random_password.rds_password.result

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = true
  port                   = 5432

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false
  copy_tags_to_snapshot   = false
  multi_az                = false

  monitoring_interval             = 0
  enabled_cloudwatch_logs_exports = []
  performance_insights_enabled    = false
  auto_minor_version_upgrade      = true
  maintenance_window              = "sun:03:00-sun:04:00"
  apply_immediately               = true

  tags = {
    Name        = "ordemservico-oficina-rds"
    Environment = "ordemservico"
    ManagedBy   = "Terraform"
  }
}
