# Output IAM role ARN
output "role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions"
  value       = aws_iam_role.github_ci.arn
}

# Output IAM role name
output "role_name" {
  description = "Name of the IAM role assumed by GitHub Actions"
  value       = aws_iam_role.github_ci.name
}