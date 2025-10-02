variable "cluster_name" {
  description = "Name of the Kind cluster."
  type        = string
  default     = "local-dev"

  validation {
    condition     = length(var.cluster_name) <= 24 && can(regex("^[a-zA-Z0-9-]+$", var.cluster_name))
    error_message = "cluster_name must be <= 24 chars and alphanumeric/hyphen."
  }
}

variable "additional_workers" {
  description = "Number of additional worker nodes."
  type        = number
  default     = 1

  validation {
    condition     = var.additional_workers >= 0 && var.additional_workers <= 5
    error_message = "additional_workers must be between 0 and 5 for local setups."
  }
}

variable "enable_ingress" {
  description = "Deploy ingress-nginx via Helm."
  type        = bool
  default     = true
}

variable "enable_metrics" {
  description = "Deploy metrics-server via Helm."
  type        = bool
  default     = true
}

variable "enable_argocd" {
  description = "Deploy Argo CD via Helm."
  type        = bool
  default     = false
}

variable "api_server_port" {
  description = "Exposed API server port on localhost."
  type        = number
  default     = 6443
}

variable "pod_subnet" {
  description = "Pod network CIDR."
  type        = string
  default     = "10.244.0.0/16"
}

variable "service_subnet" {
  description = "Service network CIDR."
  type        = string
  default     = "10.96.0.0/12"
}

variable "node_image" {
  description = "Kind node image (match Kubernetes version)."
  type        = string
  default     = "kindest/node:v1.30.0"
}

variable "extra_port_mappings" {
  description = "Host <-> container port mappings for control-plane node."
  type = list(object({
    container_port = number
    host_port      = number
    protocol       = optional(string, "TCP")
  }))
  default = [
    { container_port = 80, host_port = 80 },
    { container_port = 443, host_port = 443 }
  ]
}

variable "wait_for_ready" {
  description = "Wait for cluster nodes to become Ready."
  type        = bool
  default     = true
}
