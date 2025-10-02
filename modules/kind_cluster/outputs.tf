output "kubeconfig_path" {
  description = "Path to kubeconfig file."
  value       = local_file.kubeconfig.filename
}

output "cluster_name" {
  description = "Cluster name."
  value       = kind_cluster.this.name
}

output "raw_kubeconfig" {
  description = "Raw kubeconfig content (sensitive)."
  value       = kind_cluster.this.kubeconfig
  sensitive   = true
}
