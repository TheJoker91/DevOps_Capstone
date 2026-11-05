terraform {
  backend "s3" {
    bucket       = "devops-capstone-tfstate-686831565701"
    key          = "bootstrap/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}