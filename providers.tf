# Providers that depend on the created kubeconfig are configured
# AFTER the cluster module via 'module.kind_cluster.kubeconfig_path'
provider "kubernetes" {
  config_path = module.kind_cluster.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = module.kind_cluster.kubeconfig_path
  }
}
