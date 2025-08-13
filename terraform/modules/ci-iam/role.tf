# Trust policy per GitHub Actions via OIDC
data "aws_iam_policy_document" "assume" {
  statement {
    sid     = "GithubActionsOpenIDConnect"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.allowed_subs
    }
  }
}

resource "aws_iam_role" "gha" {
  name                 = local.role_name
  path                 = "/gha/"
  assume_role_policy   = data.aws_iam_policy_document.assume.json
  description          = "Role assumibile da GitHub Actions per CI/CD (${var.name_prefix})"
  max_session_duration = var.max_session_duration
  tags                 = var.tags

  lifecycle {
    precondition {
      condition     = local.oidc_provider_arn != null
      error_message = "OIDC provider ARN mancante. Imposta existing_oidc_provider_arn oppure abilita create_oidc_provider."
    }
  }
}

