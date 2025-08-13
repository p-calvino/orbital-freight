output "demo_secret_arn" {
  value       = aws_secretsmanager_secret.demo.arn
  description = "ARN del secret demo per injection a runtime"
}
