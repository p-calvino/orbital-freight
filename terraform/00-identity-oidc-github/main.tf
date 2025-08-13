module "ci_iam" {
  source      = "../modules/ci-iam"
  name_prefix = "orbital-freight"

  allowed_subs = [
    "repo:p-calvino/orbital-freight:ref:refs/heads/main",
  ]

  # admin = true  # <- solo per POC/emergenze
}
