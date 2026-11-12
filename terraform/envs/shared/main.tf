# Create ECR repository for the application image
module "ecr" {
  source = "../../modules/ecr"

  repository_name = "${var.project_name}-api"
}