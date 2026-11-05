# Remote state stored in S3 with native state locking
terraform {
  backend "s3" {
    bucket       = "devops-capstone-tfstate-686831565701"
    key          = "envs/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}