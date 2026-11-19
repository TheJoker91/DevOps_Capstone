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