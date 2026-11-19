# Look up the account running Terraform
data "aws_caller_identity" "current" {}

# Allow EKS Pod Identity to assume the role
data "aws_iam_policy_document" "pod_identity_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole", "sts:TagSession"]

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [var.cluster_arn]
    }
  }
}

# Create workload IAM role
resource "aws_iam_role" "workload" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.pod_identity_trust.json
}

# Create workload permissions policy
resource "aws_iam_policy" "workload" {
  name   = var.role_name
  policy = var.policy_json
}

# Attach permissions policy to role
resource "aws_iam_role_policy_attachment" "workload" {
  role       = aws_iam_role.workload.name
  policy_arn = aws_iam_policy.workload.arn
}

# Link role to Kubernetes service account
resource "aws_eks_pod_identity_association" "workload" {
  cluster_name    = var.cluster_name
  namespace       = var.namespace
  service_account = var.service_account
  role_arn        = aws_iam_role.workload.arn
}