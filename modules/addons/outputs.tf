output "ingress_nginx_status" {
  description = "Ingress nginx deployed?"
  value       = length(helm_release.ingress_nginx) > 0
}

output "metrics_server_status" {
  description = "Metrics server deployed?"
  value       = length(helm_release.metrics_server) > 0
}

output "argocd_status" {
  description = "Argo CD deployed?"
  value       = length(helm_release.argocd) > 0
}
