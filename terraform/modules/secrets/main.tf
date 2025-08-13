# 1) Solo il "contenitore" del secret (nessun valore in Terraform)
resource "aws_secretsmanager_secret" "demo" {
  name                    = "${var.name_prefix}-demo-api-key"
  description             = "Demo API key for runtime injection (set at deploy-time)"
  recovery_window_in_days = 0
}

# 2) Policy per consentire alla Lambda di leggere il secret a runtime
data "aws_iam_policy_document" "lambda_secrets_access" {
  statement {
    sid       = "AllowGetSecretValue"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [aws_secretsmanager_secret.demo.arn]
  }
}

resource "aws_iam_policy" "lambda_secrets_access" {
  name   = "${var.name_prefix}-lambda-secrets-access"
  policy = data.aws_iam_policy_document.lambda_secrets_access.json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = var.lambda_role_name
  policy_arn = aws_iam_policy.lambda_secrets_access.arn
}

# 3) (Opzionale ma consigliato) Log group + Data Protection per masking del secret nei log

resource "aws_cloudwatch_log_group" "lambda" {
  count             = var.create_log_group ? 1 : 0
  name              = local.lambda_log_group_name
  retention_in_days = var.log_retention_days
}

locals {
  lambda_log_group_name   = "/aws/lambda/${var.lambda_function_name}"
  findings_log_group_name = "${local.lambda_log_group_name}-findings"
}

resource "aws_cloudwatch_log_group" "dp_findings" {
  name              = local.findings_log_group_name
  retention_in_days = var.log_retention_days
}

resource "aws_cloudwatch_log_data_protection_policy" "mask_demo_key" {
  log_group_name = local.lambda_log_group_name

  policy_document = jsonencode({
    Name    = "${var.name_prefix}-masking"
    Version = "2021-06-01"

    Configuration = {
      CustomDataIdentifier = [
        {
          Name  = "DemoApiKey"
          Regex = "DEMO_API_KEY=[A-Za-z0-9-_+=]{10,}"
        }
      ]
    }

    Statement = [
      {
        Sid            = "Audit"
        DataIdentifier = ["DemoApiKey"]
        Operation = {
          Audit = {
            FindingsDestination = {
              CloudWatchLogs = {
                LogGroup = local.findings_log_group_name
              }
            }
          }
        }
      },
      {
        Sid            = "Deidentify"
        DataIdentifier = ["DemoApiKey"]
        Operation      = { Deidentify = { MaskConfig = {} } }
      }
    ]
  })

  depends_on = [
    aws_cloudwatch_log_group.lambda,
    aws_cloudwatch_log_group.dp_findings
  ]
}
