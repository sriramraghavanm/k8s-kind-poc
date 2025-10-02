variable "cluster_name" {
  type        = string
  description = "Kind cluster name."
}

variable "additional_workers" {
  type        = number
  description = "Number of worker nodes."
  default     = 0
}

variable "api_server_port" {
  type        = number
  description = "Host port for Kubernetes API server."
  default     = 6443
}

variable "pod_subnet" {
  type        = string
  description = "Pod CIDR."
}

variable "service_subnet" {
  type        = string
  description = "Service CIDR."
}

variable "node_image" {
  type        = string
  description = "Kind node image."
}

variable "extra_port_mappings" {
  type = list(object({
    container_port = number
    host_port      = number
    protocol       = optional(string, "TCP")
  }))
  description = "Extra port mappings for control-plane node."
  default     = []
}

variable "wait_for_ready" {
  type        = bool
  description = "Wait for readiness."
  default     = true
}

# Optional patches (advanced users)
variable "control_plane_kubeadm_patches" {
  description = "List of kubeadm patches for control-plane."
  type        = list(string)
  default     = []
}
