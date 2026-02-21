# Azure Terraform Modules

Centralized Terraform modules for Azure infrastructure, designed for lab and production use. Consume these modules from other repositories via Git refs or Terraform Registry.

## Modules

| Module | Description |
|--------|-------------|
| [resource-group](modules/resource-group) | Azure Resource Group |
| [virtual-network](modules/virtual-network) | Virtual Network with subnets |
| [network-security-group](modules/network-security-group) | NSG with rules and subnet associations |
| [network-hub-spoke](modules/network-hub-spoke) | Hub-and-spoke topology with VNet peering |
| [virtual-machine](modules/virtual-machine) | Linux and Windows VMs |
| [log-analytics-workspace](modules/log-analytics-workspace) | Log Analytics workspace |
| [azure-firewall](modules/azure-firewall) | Azure Firewall |

## Quick Start

### Consuming from another repository

Reference modules via Git (replace with your repo URL):

```hcl
module "virtual_network" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/virtual-network?ref=v1.0.0"

  name                = "my-vnet"
  resource_group_name = "rg-example"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]
  subnets = {
    default = { address_prefix = "10.0.1.0/24" }
  }
}
```

### Versioning

This repo uses [Semantic Versioning](https://semver.org/) (SemVer). Pin modules to a tagged version:

```hcl
source = "git::https://github.com/your-org/azure-terraform-modules//modules/virtual-network?ref=v1.0.0"
```

- **v1.0.0** – MAJOR.MINOR.PATCH. Always use an exact tag; version ranges (`~>`, `>=`) are not supported with Git source.
- See [VERSIONING.md](VERSIONING.md) for release process, update workflow, and changelog maintenance.
- See [CHANGELOG.md](CHANGELOG.md) for release history.

## Repository Structure

```
.
├── modules/                      # Reusable Terraform modules
│   ├── resource-group/
│   ├── virtual-network/
│   ├── network-security-group/
│   ├── network-hub-spoke/
│   ├── virtual-machine/
│   ├── log-analytics-workspace/
│   └── azure-firewall/
├── examples/                     # Usage examples
│   ├── simple-network/
│   └── lab-complete/
├── .github/workflows/            # CI (validate, lint)
├── Makefile                      # Common tasks
└── README.md
```

## Examples

- **[simple-network](examples/simple-network)** – Single VNet with subnets and NSG
- **[lab-complete](examples/lab-complete)** – Hub-spoke, Azure Firewall, Log Analytics

## Development

```bash
# Format all Terraform files
make fmt

# Validate a specific module
make validate MODULE=virtual-network

# Validate all modules
make test

# Generate documentation (requires terraform-docs)
make docs
```

## Best Practices

1. **Version pinning** – Always use `ref=` with a tag when consuming modules.
2. **Tags** – Apply consistent tags across all resources.
3. **Composition** – Compose modules in your root config; avoid deep nesting.
4. **Separation** – Keep each module focused on a single concern.

## License

See [LICENSE](LICENSE) file.
