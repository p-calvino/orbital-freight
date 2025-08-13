output "api_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "codedeploy_app" {
  value = aws_codedeploy_app.this.name
}

output "codedeploy_deployment_group" {
  value = aws_codedeploy_deployment_group.this.deployment_group_name
}

output "lambda_function_name" {
  value = aws_lambda_function.app.function_name
}

output "lambda_alias_name" {
  value = aws_lambda_alias.live.name
}

output "api_id" {
  value = aws_apigatewayv2_api.api.id
}

output "lambda_role_name" {
  value       = aws_iam_role.lambda_exec.name
  description = "Execution role name della Lambda"
}
