# AWS provider with default tags
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "shared"
      ManagedBy   = "terraform"
      Repository  = "TheJoker91/DevOps_Capstone"
    }
  }
}