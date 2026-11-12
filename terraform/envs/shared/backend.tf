# Remote state backend
terraform {
  backend "s3" {
    bucket       = "devops-capstone-tfstate-686831565701"
    key          = "envs/shared/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}