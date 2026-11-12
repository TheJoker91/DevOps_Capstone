# Output ECR repository URL
output "ecr_repository_url" {
  description = "URL used to push and pull application images"
  value       = module.ecr.repository_url
}

# Output ECR repository ARN
output "ecr_repository_arn" {
  description = "ARN of the ECR repository, used in IAM policies"
  value       = module.ecr.repository_arn
}