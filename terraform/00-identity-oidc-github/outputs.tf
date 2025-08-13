output "role_arn" {
  description = "ARN dell'OIDC provider GitHub"
  value       = module.ci_iam.role_arn
}
