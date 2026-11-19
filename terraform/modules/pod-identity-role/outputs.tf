# IAM role ARN
output "role_arn" {
  description = "ARN of the workload IAM role"
  value       = aws_iam_role.workload.arn
}

# IAM role name
output "role_name" {
  description = "Name of the workload IAM role"
  value       = aws_iam_role.workload.name
}

# Pod Identity association ID
output "association_id" {
  description = "ID of the EKS Pod Identity association"
  value       = aws_eks_pod_identity_association.workload.association_id
}