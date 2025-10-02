output "kubeconfig_path" {
  description = "Path to generated kubeconfig for this Kind cluster."
  value       = module.kind_cluster.kubeconfig_path
  sensitive   = false
}

output "cluster_name" {
  description = "Name of the cluster."
  value       = module.kind_cluster.cluster_name
}

output "kubectl_setup_command" {
  description = "Command to export kubeconfig environment variable."
  value       = "export KUBECONFIG=${module.kind_cluster.kubeconfig_path}"
}

output "addons_status" {
  description = "Summary of enabled addons."
  value = {
    ingress_enabled = var.enable_ingress
    metrics_enabled = var.enable_metrics
    argocd_enabled  = var.enable_argocd
  }
}
