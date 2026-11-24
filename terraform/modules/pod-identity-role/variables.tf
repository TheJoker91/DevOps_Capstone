# EKS cluster name
variable "cluster_name" {
  description = "Name of the EKS cluster the association is created in"
  type        = string
}

# EKS cluster ARN
variable "cluster_arn" {
  description = "ARN of the EKS cluster allowed to assume the role"
  type        = string

  validation {
    condition     = can(regex("^arn:aws:eks:[a-z0-9-]+:[0-9]{12}:cluster/.+$", var.cluster_arn))
    error_message = "cluster_arn must be a valid EKS cluster ARN."
  }
}

# IAM role name
variable "role_name" {
  description = "Name of the IAM role and its permissions policy"
  type        = string

  validation {
    condition     = length(var.role_name) <= 64
    error_message = "role_name must be 64 characters or fewer."
  }
}

# Kubernetes namespace
variable "namespace" {
  description = "Namespace of the service account that receives the role"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$", var.namespace))
    error_message = "namespace must be a valid Kubernetes name."
  }
}

# Kubernetes service account
variable "service_account" {
  description = "Name of the service account that receives the role"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9.]*[a-z0-9])?$", var.service_account))
    error_message = "service_account must be a valid Kubernetes name."
  }
}

# IAM permissions policy
variable "policy_json" {
  description = "IAM policy document (JSON) granting the workload its AWS permissions"
  type        = string

  validation {
    condition     = can(jsondecode(var.policy_json))
    error_message = "policy_json must be valid JSON."
  }
}