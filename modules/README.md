# Modules

Reusable Terraform modules for Azure infrastructure. Each module is self-contained with its own `main.tf`, `variables.tf`, `outputs.tf`, and `terraform.tf`.

## Consuming Modules

Reference modules from other repositories using Git source:

```hcl
source = "git::https://github.com/YOUR_ORG/azure-terraform-modules//modules/MODULE_NAME?ref=TAG"
```

Replace:
- `YOUR_ORG` – Your GitHub organization or username
- `MODULE_NAME` – Module folder name (e.g., `virtual-network`, `network-hub-spoke`)
- `TAG` – Semantic version tag (e.g., `v1.0.0`)
