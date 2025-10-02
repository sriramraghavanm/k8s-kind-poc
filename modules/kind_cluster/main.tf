resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = var.wait_for_ready
  node_image     = var.node_image

  kind_config {
    api_version = "kind.x-k8s.io/v1alpha4"
    kind        = "Cluster"

    networking {
      api_server_port = var.api_server_port
      pod_subnet      = var.pod_subnet
      service_subnet  = var.service_subnet
    }

    node {
      role = "control-plane"

      extra_port_mappings = [
        for m in var.extra_port_mappings : {
          container_port = m.container_port
          host_port      = m.host_port
          protocol       = m.protocol
        }
      ]

      kubeadm_config_patches = var.control_plane_kubeadm_patches
      labels = {
        "node-role.kubernetes.io/control-plane" = "true"
      }
    }

    dynamic "node" {
      for_each = range(var.additional_workers)
      content {
        role = "worker"
        labels = {
          "node-pool" = "worker-${node.key}"
        }
      }
    }
  }
}

# Persist kubeconfig securely
resource "local_file" "kubeconfig" {
  content         = kind_cluster.this.kubeconfig
  filename        = "${path.root}/kubeconfig_${var.cluster_name}"
  file_permission = "0600"
}

# Convenience environment script
resource "local_file" "env_export" {
  content         = "export KUBECONFIG=${local_file.kubeconfig.filename}\n"
  filename        = "${path.root}/export_${var.cluster_name}_kubeconfig.sh"
  file_permission = "0750"
}

