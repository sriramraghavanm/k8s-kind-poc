# Local Kubernetes Cluster with Terraform (Kind + Add-ons)

## Overview
This Terraform configuration provisions a local Kubernetes cluster using [Kind](https://kind.sigs.k8s.io/) (Kubernetes-in-Docker) and optionally deploys common add-ons via Helm:
- Ingress-NGINX
- Metrics Server
- Argo CD

It emphasizes:
- Modular architecture (cluster module + addons module)
- Version pinning for providers
- Declarative kubeconfig management
- Safe variable validation
- Optional remote backend (example commented)
- Security recommendations for local development

> NOTE: This setup is intended for local development / testing, not production.

---

## Prerequisites

| Tool | Min Version | Purpose |
|------|-------------|---------|
| Terraform | 1.7+ | IaC engine |
| Docker | 20+ | Required by Kind |
| kubectl | Latest stable | Interact with cluster |
| Helm (optional) | 3.x | Debug / manual ops |

## Quick Start

```bash
git clone <your-repo>
cd <your-repo>

# (optional) Create tfvars
cp terraform.tfvars.example terraform.tfvars

terraform init
terraform plan
terraform apply -auto-approve

# Use kubeconfig
export KUBECONFIG=$(pwd)/kubeconfig_local-dev
kubectl get nodes
```

To destroy:
```bash
terraform destroy
```

---

## Structure

```
.
├── main.tf
├── versions.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
├── modules
│   ├── kind_cluster
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── addons
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── scripts
    └── README.md (future: helper scripts)
```

---

## Add-ons

Enable via variables:
```hcl
enable_ingress       = true
enable_metrics        = true
enable_argocd         = true
```

---

## Example `terraform.tfvars`
```hcl
cluster_name        = "local-dev"
enable_ingress      = true
enable_metrics      = true
enable_argocd       = false
additional_workers  = 2
```

---

## Security & Best Practices

- Never commit generated kubeconfig (`kubeconfig_<cluster_name>`) to version control.
- Use a remote backend (e.g., Terraform Cloud, S3) if collaborating (see `versions.tf` comment).
- Use tools like:
  - `tfsec .`
  - `checkov -d .`
  - `tflint`
- Rotate Kind node image occasionally to track upstream CVEs.
- Keep provider versions pinned (already done).

---

## Extending

Add more modules (e.g., logging, cert-manager):
```
modules/
  cert_manager/
  logging/
```

---

## Troubleshooting

| Issue | Resolution |
|-------|------------|
| Stuck waiting for cluster | Run `docker ps` to confirm Kind nodes |
| kubeconfig not applied | Use `export KUBECONFIG=$(pwd)/kubeconfig_local-dev` |
| Helm release timeout | Increase `timeout` in module `addons` |
| Ingress not reachable | Confirm port mappings: `localhost:80` / `443` |

---

## Destroy Safety

Local cluster is ephemeral. If you add persistence (e.g., hostPath volumes) remember to manually clean them if needed.

---

## License

MIT (suggested) – pick what suits your repository.

---
