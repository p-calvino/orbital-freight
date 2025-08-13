resource "aws_iam_openid_connect_provider" "github" {
  count           = var.create_oidc_provider && var.existing_oidc_provider_arn == null ? 1 : 0
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.github_oidc_thumbprints
  tags            = var.tags
  lifecycle {
    prevent_destroy = true
  }
}
