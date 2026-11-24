# Install AWS Load Balancer Controller
resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "3.6.3"
  namespace  = "kube-system"

  values = [yamlencode({
    clusterName = module.eks.cluster_name
    region      = var.region
    vpcId       = module.vpc.vpc_id
    serviceAccount = {
      create = true
      name   = "aws-load-balancer-controller"
    }
  })]

  depends_on = [module.eks, module.lb_controller_role]
}

# Install Cluster Autoscaler
resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.60.0"
  namespace  = "kube-system"

  values = [yamlencode({
    fullnameOverride = "cluster-autoscaler"
    awsRegion        = var.region
    autoDiscovery = {
      clusterName = module.eks.cluster_name
    }
    image = {
      tag = "v1.36.2"
    }
    rbac = {
      serviceAccount = {
        create = true
        name   = "cluster-autoscaler"
      }
    }
  })]

  depends_on = [
    module.eks,
    module.cluster_autoscaler_role,
    helm_release.aws_load_balancer_controller,
  ]
}