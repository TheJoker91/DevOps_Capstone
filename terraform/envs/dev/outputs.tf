# Output name prefix
output "name_prefix" {
  description = "Prefix used for resource names in this environment"
  value       = local.name_prefix
}

# Output VPC ID
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

# Output public subnet IDs
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

# Output private subnet IDs
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

# Output NAT gateway public IP
output "nat_public_ip" {
  description = "Public IP address used for outbound traffic from private subnets"
  value       = module.vpc.nat_public_ip
}

# Output EKS cluster name
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

# Output EKS cluster endpoint
output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster API"
  value       = module.eks.cluster_endpoint
}

# Output EKS cluster version
output "cluster_version" {
  description = "Kubernetes version of the EKS cluster"
  value       = module.eks.cluster_version
}

# Output kubeconfig command
output "configure_kubectl" {
  description = "Command to configure kubectl for this cluster"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}