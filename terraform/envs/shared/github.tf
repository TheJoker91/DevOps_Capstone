# Look up the existing GitHub Actions OIDC provider
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# Create IAM role for GitHub Actions to push images
module "github_ci_role" {
  source = "../../modules/github-oidc-role"

  role_name          = "${var.project_name}-github-ci"
  oidc_provider_arn  = data.aws_iam_openid_connect_provider.github.arn
  github_repository  = var.github_repository
  allowed_branches   = ["main"]
  ecr_repository_arn = module.ecr.repository_arn
}