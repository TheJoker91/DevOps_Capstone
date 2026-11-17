# Deployment environment
environment = "dev"

# VPC CIDR block
vpc_cidr = "10.0.0.0/16"

# Availability zones
azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Public subnet CIDR blocks
public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]

# Private subnet CIDR blocks
private_subnet_cidrs = ["10.0.32.0/19", "10.0.64.0/19", "10.0.96.0/19"]

# Kubernetes version
kubernetes_version = "1.36"

# Worker node instance types
node_instance_types = ["t3.medium", "t3a.medium"]

# Worker node capacity type
node_capacity_type = "SPOT"

# Worker node count
node_desired_size = 2
node_min_size     = 2
node_max_size     = 3