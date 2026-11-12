# Output repository name
output "repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.images.name
}

# Output repository URL
output "repository_url" {
  description = "URL used to push and pull images"
  value       = aws_ecr_repository.images.repository_url
}

# Output repository ARN
output "repository_arn" {
  description = "ARN of the ECR repository, used in IAM policies"
  value       = aws_ecr_repository.images.arn
}