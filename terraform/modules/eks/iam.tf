# Trust policy allowing the EKS service to assume the cluster role
data "aws_iam_policy_document" "cluster_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole", "sts:TagSession"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

# Create IAM role for the EKS cluster
resource "aws_iam_role" "cluster" {
  name               = "${var.cluster_name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role.json
}

# Attach EKS cluster policy to the cluster role
resource "aws_iam_role_policy_attachment" "cluster" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Trust policy allowing EC2 instances to assume the node role
data "aws_iam_policy_document" "node_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create IAM role for the worker nodes
resource "aws_iam_role" "node" {
  name               = "${var.cluster_name}-node-role"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json
}

# Attach worker node policies to the node role
resource "aws_iam_role_policy_attachment" "node" {
  for_each = {
    worker_node   = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    vpc_cni       = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    ecr_read_only = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }

  role       = aws_iam_role.node.name
  policy_arn = each.value
}