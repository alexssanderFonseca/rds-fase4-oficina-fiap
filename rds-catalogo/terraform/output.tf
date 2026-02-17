data "aws_secretsmanager_secret" "rds_password_secret_data" {
  name = aws_secretsmanager_secret.rds_password_secret.name
}

data "aws_secretsmanager_secret_version" "rds_password_secret_version_data" {
  secret_id = data.aws_secretsmanager_secret.rds_password_secret_data.id
}

output "rds_endpoint" {
  description = "Endpoint de conexão do RDS Catalogo"
  value       = aws_db_instance.academico_rds.endpoint
}

output "rds_address" {
  description = "Endereço do RDS Catalogo"
  value       = aws_db_instance.academico_rds.address
}

output "rds_port" {
  description = "Porta do RDS Catalogo"
  value       = aws_db_instance.academico_rds.port
}

output "database_name" {
  description = "Nome do banco de dados Catalogo"
  value       = aws_db_instance.academico_rds.db_name
}


output "connection_info" {
  description = "Como conectar ao banco Catalogo"
  value       = <<-EOT
    
    📋 INFORMAÇÕES DE CONEXÃO:
    
    1. Endpoint: ${aws_db_instance.academico_rds.endpoint}
    2. Username: ${aws_db_instance.academico_rds.username}
    3. Password: ${data.aws_secretsmanager_secret_version.rds_password_secret_version_data.secret_string}
    
    ⚠️ IMPORTANTE: Sempre PARE ou EXCLUA o RDS ao final do uso!
  EOT
  sensitive = true
}
