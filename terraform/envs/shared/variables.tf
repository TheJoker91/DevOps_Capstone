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

# GitHub repository allowed to push images
variable "github_repository" {
  description = "GitHub repository in owner/name form whose workflows may push images"
  type        = string
  default     = "TheJoker91/DevOps_Capstone"
}