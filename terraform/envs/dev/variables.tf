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