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

# Install Argo CD
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "10.20.0"
  namespace        = "argocd"
  create_namespace = true

  values = [yamlencode({
    dex = {
      enabled = false
    }
    notifications = {
      enabled = false
    }
  })]

  depends_on = [module.eks, helm_release.aws_load_balancer_controller]
}

# Register dev application with Argo CD
resource "helm_release" "argocd_apps" {
  name       = "argocd-apps"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "2.0.10"
  namespace  = "argocd"

  values = [yamlencode({
    applications = {
      "capstone-api-dev" = {
        namespace  = "argocd"
        project    = "default"
        finalizers = ["resources-finalizer.argocd.argoproj.io"]
        source = {
          repoURL        = "https://github.com/TheJoker91/DevOps_Capstone.git"
          targetRevision = var.gitops_target_revision
          path           = "helm/capstone-api"
          helm = {
            releaseName = "capstone-api"
            valueFiles  = ["../../gitops/dev/values.yaml"]
          }
        }
        destination = {
          server    = "https://kubernetes.default.svc"
          namespace = "capstone-dev"
        }
        syncPolicy = {
          automated = {
            prune    = true
            selfHeal = true
          }
          syncOptions = ["CreateNamespace=true"]
        }
      }
    }
  })]

  depends_on = [helm_release.argocd]
}