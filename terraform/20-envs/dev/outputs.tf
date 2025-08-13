output "api_url" {
  value = module.compute.api_url
}

output "codedeploy_app" {
  value = module.compute.codedeploy_app
}

output "codedeploy_deployment_group" {
  value = module.compute.codedeploy_deployment_group
}

output "cloudwatch_dashboard_url" {
  value = module.monitoring.dashboard_url
}

output "demo_secret_arn" {
  value = module.secrets.demo_secret_arn
}

output "lambda_function_name" {
  value = module.compute.lambda_function_name
}
