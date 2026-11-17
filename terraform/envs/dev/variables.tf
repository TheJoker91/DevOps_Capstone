# Project name
variable "project_name" {
  description = "Short project name, used as a prefix for resource names"
  type        = string
  default     = "devops-capstone"
}

# Deployment environment
variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be \"dev\" or \"prod\"."
  }
}

# AWS region
variable "region" {
  description = "AWS region for this environment"
  type        = string
  default     = "us-east-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
}

# Availability zones
variable "azs" {
  description = "Availability Zones to spread subnets across"
  type        = list(string)
}

# Public subnet CIDR blocks
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets, one per Availability Zone"
  type        = list(string)
}

# Private subnet CIDR blocks
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets, one per Availability Zone"
  type        = list(string)
}

# Kubernetes version
variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
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
}

# IP ranges allowed to reach the cluster API
variable "admin_cidrs" {
  description = "CIDR blocks allowed to reach the public EKS API endpoint"
  type        = list(string)

  validation {
    condition     = alltrue([for cidr in var.admin_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Each entry in admin_cidrs must be a valid CIDR, for example 203.0.113.10/32."
  }
}