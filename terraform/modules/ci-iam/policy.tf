data "aws_iam_policy_document" "gha_ci" {
  count = var.admin ? 0 : 1

  ########################################
  # IAM 
  ########################################
  statement {
    sid    = "IamManagement"
    effect = "Allow"
    actions = [
      "iam:*Role*",
      "iam:*Policy*",
      "iam:PassRole"
    ]
    resources = [
      "arn:${local.part}:iam::*:role/*${var.name_prefix}*",
      "arn:${local.part}:iam::*:policy/*${var.name_prefix}*"
    ]
  }

  ########################################
  # ECR
  ########################################
  statement {
    sid     = "EcrFullAccess"
    effect  = "Allow"
    actions = ["ecr:*"]
    resources = [
      "arn:${local.part}:ecr:${local.region}:${local.account_id}:repository/${var.name_prefix}*",
      "*"
    ]
  }

  ########################################
  # S3
  ########################################
  statement {
    sid     = "S3FullAccess"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "arn:${local.part}:s3:::${var.name_prefix}*",
      "arn:${local.part}:s3:::${var.name_prefix}*/*"
    ]
  }

  ########################################
  # DynamoDB
  ########################################
  statement {
    sid     = "DynamoDBFullAccess"
    effect  = "Allow"
    actions = ["dynamodb:*"]
    resources = [
      "arn:${local.part}:dynamodb:${local.region}:${local.account_id}:table/${var.name_prefix}*"
    ]
  }

  ########################################
  # Lambda
  ########################################
  statement {
    sid     = "LambdaFullAccess"
    effect  = "Allow"
    actions = ["lambda:*"]
    resources = [
      "arn:${local.part}:lambda:${local.region}:${local.account_id}:function:${var.name_prefix}*",
      "arn:${local.part}:lambda:${local.region}:${local.account_id}:layer:${var.name_prefix}*",
      "*"
    ]
  }

  ########################################
  # API Gateway v1/v2
  ########################################
  statement {
    sid    = "APIGatewayFullAccess"
    effect = "Allow"
    actions = [
      "apigateway:*",
      "apigatewayv2:*"
    ]
    resources = ["*"]
  }

  ########################################
  # CodeDeploy
  ########################################
  statement {
    sid       = "CodeDeployFullAccess"
    effect    = "Allow"
    actions   = ["codedeploy:*"]
    resources = ["*"]
  }

  ########################################
  # Secrets Manager
  ########################################
  statement {
    sid     = "SecretsManagerAccess"
    effect  = "Allow"
    actions = ["secretsmanager:*"]
    resources = [
      "arn:${local.part}:secretsmanager:${local.region}:${local.account_id}:secret:${var.name_prefix}*"
    ]
  }

  ########################################
  # SNS
  ########################################
  statement {
    sid     = "SNSAccess"
    effect  = "Allow"
    actions = ["sns:*"]
    resources = [
      "arn:${local.part}:sns:${local.region}:${local.account_id}:${var.name_prefix}*"
    ]
  }

  ########################################
  # Monitoring e Logs
  ########################################
  statement {
    sid    = "MonitoringAndLogs"
    effect = "Allow"
    actions = [
      "cloudwatch:*",
      "logs:*",
      "events:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "gha_ci" {
  count       = var.admin ? 0 : 1
  name        = local.policy_name
  path        = "/gha/"
  description = "CI/CD policy semplificata per demo - ${var.name_prefix}"
  policy      = data.aws_iam_policy_document.gha_ci[0].json
  tags        = var.tags
}
