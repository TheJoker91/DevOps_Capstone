variable "project_name" {
  description = "Short project name, used as a prefix for resource names"
  type        = string
  default     = "devops-capstone"
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be \"dev\" or \"prod\"."
  }
}

variable "region" {
  description = "AWS region for this environment"
  type        = string
  default     = "us-east-1"
}