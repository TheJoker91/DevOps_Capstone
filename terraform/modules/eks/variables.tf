# Cluster name
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

# Kubernetes version
variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

# Subnets for the cluster and worker nodes
variable "subnet_ids" {
  description = "Private subnet IDs for the cluster and worker nodes"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnets in different Availability Zones are required."
  }
}

# IP ranges allowed to reach the public API endpoint
variable "endpoint_public_access_cidrs" {
  description = "CIDR blocks allowed to reach the public EKS API endpoint"
  type        = list(string)

  validation {
    condition     = alltrue([for cidr in var.endpoint_public_access_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Each entry must be a valid CIDR, for example 203.0.113.10/32."
  }
}

# IAM principals granted cluster admin access
variable "admin_principal_arns" {
  description = "IAM user or role ARNs granted cluster admin access"
  type        = list(string)
}

# Control plane log retention
variable "log_retention_days" {
  description = "Days to keep control plane logs in CloudWatch"
  type        = number
  default     = 7
}

# Node instance types
variable "node_instance_types" {
  description = "EC2 instance types for the worker nodes"
  type        = list(string)
}

# Node capacity type
variable "node_capacity_type" {
  description = "Capacity type for the worker nodes: ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

# Node count
variable "node_desired_size" {
  description = "Number of worker nodes to run normally"
  type        = number
}

# Minimum node count
variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

# Maximum node count
variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number

  validation {
    condition     = var.node_max_size >= var.node_min_size
    error_message = "node_max_size must be greater than or equal to node_min_size."
  }
}