# IAM role name
variable "role_name" {
  description = "Name of the IAM role assumed by GitHub Actions"
  type        = string
}

# GitHub OIDC provider ARN
variable "oidc_provider_arn" {
  description = "ARN of the IAM OIDC identity provider for token.actions.githubusercontent.com"
  type        = string
}

# GitHub repository allowed to assume the role
variable "github_repository" {
  description = "GitHub repository in owner/name form, for example TheJoker91/DevOps_Capstone"
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repository))
    error_message = "github_repository must be in owner/name form, with no wildcards."
  }
}

# Branches allowed to assume the role
variable "allowed_branches" {
  description = "Branches whose workflows may assume the role"
  type        = list(string)
  default     = ["main"]

  validation {
    condition     = length(var.allowed_branches) > 0 && alltrue([for branch in var.allowed_branches : !strcontains(branch, "*")])
    error_message = "allowed_branches must list at least one branch, with no wildcards."
  }
}

# ECR repository the role may push to
variable "ecr_repository_arn" {
  description = "ARN of the ECR repository the role may push images to"
  type        = string
}

# Maximum session length
variable "max_session_duration" {
  description = "Maximum session length in seconds for the role"
  type        = number
  default     = 3600
}