locals {
  lambda_alias          = "live"
  lambda_alias_arn      = "arn:aws:lambda:${data.aws_region.this.region}:${data.aws_caller_identity.this.account_id}:function:${aws_lambda_function.app.function_name}:${local.lambda_alias}"
  apigw_integration_uri = "arn:aws:apigateway:${data.aws_region.this.region}:lambda:path/2015-03-31/functions/${local.lambda_alias_arn}/invocations"
}
