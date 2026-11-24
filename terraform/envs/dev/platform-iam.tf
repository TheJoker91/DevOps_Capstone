# Grant AWS Load Balancer Controller its AWS permissions
module "lb_controller_role" {
  source = "../../modules/pod-identity-role"

  cluster_name    = module.eks.cluster_name
  cluster_arn     = module.eks.cluster_arn
  role_name       = "${local.name_prefix}-aws-lb-controller"
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  policy_json     = file("${path.module}/policies/aws-load-balancer-controller.json")
}

# Define Cluster Autoscaler permissions
data "aws_iam_policy_document" "cluster_autoscaler" {
  statement {
    sid    = "DescribeScalingResources"
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeTags",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:GetInstanceTypesFromInstanceRequirements",
      "eks:DescribeNodegroup",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "ScaleClusterNodeGroups"
    effect = "Allow"
    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
    ]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/k8s.io/cluster-autoscaler/${module.eks.cluster_name}"
      values   = ["owned"]
    }
  }
}

# Grant Cluster Autoscaler its AWS permissions
module "cluster_autoscaler_role" {
  source = "../../modules/pod-identity-role"

  cluster_name    = module.eks.cluster_name
  cluster_arn     = module.eks.cluster_arn
  role_name       = "${local.name_prefix}-cluster-autoscaler"
  namespace       = "kube-system"
  service_account = "cluster-autoscaler"
  policy_json     = data.aws_iam_policy_document.cluster_autoscaler.json
}