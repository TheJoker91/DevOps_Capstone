# Common local values
locals {
  # Prefix for every resource name in this environment, e.g. "devops-capstone-prod"
  name_prefix = "${var.project_name}-${var.environment}"
}
