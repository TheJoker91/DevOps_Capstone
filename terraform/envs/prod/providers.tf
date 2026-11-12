# AWS provider with default tags applied to all resources
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Repository  = "TheJoker91/DevOps_Capstone"
    }
  }
}