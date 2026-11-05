locals {
  # Prefix for every resource name in this environment, e.g. "devops-capstone-dev"
  name_prefix = "${var.project_name}-${var.environment}"
}
