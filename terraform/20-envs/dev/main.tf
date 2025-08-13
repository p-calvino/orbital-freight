module "compute" {
  source                   = "../../modules/compute"
  image_uri                = var.image_uri
  name_prefix              = local.name_prefix
  lambda_arch              = var.lambda_arch
  codedeploy_alarm_enabled = true
  codedeploy_alarm_names   = [module.monitoring.apigw_5xx_alarm_name]
}

module "monitoring" {
  source      = "../../modules/monitoring"
  name_prefix = local.name_prefix
  api_id      = module.compute.api_id
  alarm_email = var.alarm_email
  aws_region  = var.aws_region
}

module "secrets" {
  source               = "../../modules/secrets"
  name_prefix          = local.name_prefix
  lambda_role_name     = module.compute.lambda_role_name
  lambda_function_name = module.compute.lambda_function_name

  create_log_group   = true
  log_retention_days = 14
}
