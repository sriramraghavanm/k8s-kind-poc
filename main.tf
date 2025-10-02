module "kind_cluster" {
  source              = "./modules/kind_cluster"
  cluster_name        = var.cluster_name
  additional_workers  = var.additional_workers
  api_server_port     = var.api_server_port
  pod_subnet          = var.pod_subnet
  service_subnet      = var.service_subnet
  node_image          = var.node_image
  extra_port_mappings = var.extra_port_mappings
  wait_for_ready      = var.wait_for_ready
}

module "addons" {
  source          = "./modules/addons"
  enable_ingress  = var.enable_ingress
  enable_metrics  = var.enable_metrics
  enable_argocd   = var.enable_argocd

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
  kubeconfig_path = module.kind_cluster.kubeconfig_path
}

# Example: create a demo namespace via Kubernetes provider (post cluster creation)
resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo"
    labels = {
      "purpose" = "example"
    }
  }
  depends_on = [module.kind_cluster]
}
