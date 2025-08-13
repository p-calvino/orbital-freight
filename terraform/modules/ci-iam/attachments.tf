# Allego AdministratorAccess se admin=true
resource "aws_iam_role_policy_attachment" "admin" {
  count      = var.admin ? 1 : 0
  role       = aws_iam_role.gha.name
  policy_arn = "arn:${local.part}:iam::aws:policy/AdministratorAccess"
}

# Allego la policy least-privilege al ruolo (se admin=false)
resource "aws_iam_role_policy_attachment" "gha_ci" {
  count      = var.admin ? 0 : 1
  role       = aws_iam_role.gha.name
  policy_arn = aws_iam_policy.gha_ci[0].arn
}
