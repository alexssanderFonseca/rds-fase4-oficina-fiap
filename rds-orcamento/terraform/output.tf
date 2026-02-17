output "rds_endpoint" {
  description = "Endpoint de conexão do RDS Orcamento"
  value       = aws_db_instance.academico_rds.endpoint
}

output "rds_address" {
  description = "Endereço do RDS Orcamento"
  value       = aws_db_instance.academico_rds.address
}

output "rds_port" {
  description = "Porta do RDS Orcamento"
  value       = aws_db_instance.academico_rds.port
}

output "database_name" {
  description = "Nome do banco de dados Orcamento"
  value       = aws_db_instance.academico_rds.db_name
}


output "connection_info" {
  description = "Como conectar ao banco Orcamento"
  value       = <<-EOT
    
    📋 INFORMAÇÕES DE CONEXÃO:
    
    1. Endpoint: ${aws_db_instance.academico_rds.endpoint}
    2. Username: ${aws_db_instance.academico_rds.username}
    
    ⚠️ IMPORTANTE: Sempre PARE ou EXCLUA o RDS ao final do uso!
  EOT
  sensitive   = true
}
