# Name prefix for all resources in this environment
locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# Create VPC
module "vpc" {
  source = "../../modules/vpc"

  name                 = local.name_prefix
  cidr_block           = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}