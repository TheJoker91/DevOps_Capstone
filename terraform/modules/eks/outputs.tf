# Output cluster name
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

# Output cluster endpoint
output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster API"
  value       = aws_eks_cluster.main.endpoint
}

# Output cluster version
output "cluster_version" {
  description = "Kubernetes version of the EKS cluster"
  value       = aws_eks_cluster.main.version
}

# Output cluster ARN
output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = aws_eks_cluster.main.arn
}

# Output cluster security group ID
output "cluster_security_group_id" {
  description = "Security group created by EKS for the control plane and nodes"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

# Output node IAM role ARN
output "node_role_arn" {
  description = "ARN of the IAM role used by the worker nodes"
  value       = aws_iam_role.node.arn
}

# Cluster CA certificate
output "cluster_certificate_authority_data" {
  description = "Base64-encoded certificate authority data for the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}