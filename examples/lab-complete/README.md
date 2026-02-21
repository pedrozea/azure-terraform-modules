# Complete Lab Example

Deploys a full lab environment with:

- Resource group
- Hub-spoke network topology
- Azure Firewall in the hub
- NSGs on spoke subnets
- Log Analytics workspace

**Note:** Does not include VMs by default to minimize cost. Add the virtual-machine module if needed.

## Usage

```bash
terraform init
terraform plan -var="environment=lab"
terraform apply -var="environment=lab"
```

## Consuming from another repo

When consuming these modules from another repository, use the `source` argument with a Git ref:

```hcl
module "network_hub_spoke" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/network-hub-spoke?ref=v1.0.0"
  # ...
}
```
