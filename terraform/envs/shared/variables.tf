# Project name
variable "project_name" {
  description = "Short project name, used as a prefix for resource names"
  type        = string
  default     = "devops-capstone"
}

# AWS region
variable "region" {
  description = "AWS region for shared resources"
  type        = string
  default     = "us-east-1"
}