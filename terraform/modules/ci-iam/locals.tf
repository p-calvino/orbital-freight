locals {
  account_id = data.aws_caller_identity.this.account_id
  region     = data.aws_region.this.region
  part       = data.aws_partition.this.partition

  role_name   = "${var.name_prefix}-gha-oidc"
  policy_name = "${var.name_prefix}-gha-ci"

  oidc_provider_arn = coalesce(
    var.existing_oidc_provider_arn,
    try(aws_iam_openid_connect_provider.github[0].arn, null)
  )
}
