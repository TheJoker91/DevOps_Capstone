# Look up the identity running Terraform
data "aws_caller_identity" "caller" {}

# Resolve the IAM user or role behind that identity
data "aws_iam_session_context" "caller" {
  arn = data.aws_caller_identity.caller.arn
}

# Create EKS cluster
module "eks" {
  source = "../../modules/eks"

  cluster_name       = "${local.name_prefix}-eks"
  kubernetes_version = var.kubernetes_version

  subnet_ids                   = module.vpc.private_subnet_ids
  endpoint_public_access_cidrs = var.admin_cidrs
  admin_principal_arns         = [data.aws_iam_session_context.caller.issuer_arn]

  node_instance_types = var.node_instance_types
  node_capacity_type  = var.node_capacity_type
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
}