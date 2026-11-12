# Repository name
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

# Image tag mutability
variable "image_tag_mutability" {
  description = "Whether image tags can be overwritten (MUTABLE) or not (IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

# Scan images on push
variable "scan_on_push" {
  description = "Run a basic vulnerability scan when an image is pushed"
  type        = bool
  default     = true
}

# Number of tagged images to keep
variable "max_image_count" {
  description = "Number of most recent tagged images to keep; older ones are deleted"
  type        = number
  default     = 20

  validation {
    condition     = var.max_image_count >= 1
    error_message = "max_image_count must be at least 1."
  }
}

# Days to keep untagged images
variable "untagged_image_expiry_days" {
  description = "Days after which untagged images are deleted"
  type        = number
  default     = 7

  validation {
    condition     = var.untagged_image_expiry_days >= 1
    error_message = "untagged_image_expiry_days must be at least 1."
  }
}