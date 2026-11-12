# Output state bucket name
output "state_bucket_name" {
  description = "S3 bucket that stores Terraform state for this project"
  value       = aws_s3_bucket.state.bucket
}

# Output region
output "region" {
  description = "Region of the state bucket"
  value       = var.region
}