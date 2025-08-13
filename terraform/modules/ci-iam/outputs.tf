output "role_name" {
  value       = aws_iam_role.gha.name
  description = "Nome del ruolo IAM per GitHub Actions."
}

output "role_arn" {
  value       = aws_iam_role.gha.arn
  description = "ARN del ruolo IAM per GitHub Actions."
}

output "policy_arn" {
  value       = try(aws_iam_policy.gha_ci[0].arn, null)
  description = "ARN della policy least-privilege (null se admin=true)."
}

output "oidc_provider_arn" {
  value       = local.oidc_provider_arn
  description = "ARN dell'OIDC provider GitHub utilizzato o creato."
}
