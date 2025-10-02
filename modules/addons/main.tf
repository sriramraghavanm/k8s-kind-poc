locals {
  kubeconfig = var.kubeconfig_path
}

# Ingress-NGINX
resource "helm_release" "ingress_nginx" {
  count      = var.enable_ingress ? 1 : 0
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = true
  timeout    = 300
  atomic     = true

  values = [
    yamlencode({
      controller = {
        publishService = { enabled = true }
      }
    })
  ]
}

# Metrics Server
resource "helm_release" "metrics_server" {
  count      = var.enable_metrics ? 1 : 0
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  timeout    = 300
  atomic     = true

  values = [
    yamlencode({
      args = [
        "--kubelet-insecure-tls",
        "--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname"
      ]
    })
  ]
}

# Argo CD
resource "helm_release" "argocd" {
  count      = var.enable_argocd ? 1 : 0
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"
  create_namespace = true
  timeout    = 600
  atomic     = true

  values = [
    yamlencode({
      server = {
        service = {
          type = "ClusterIP"
        }
      }
    })
  ]
}
