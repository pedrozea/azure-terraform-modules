# Virtual Network Module

Creates an Azure Virtual Network with configurable subnets. Supports optional subnet delegation for Azure services (AKS, Azure Firewall, etc.).

## Usage

```hcl
module "virtual_network" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/virtual-network?ref=v1.0.0"

  name                = "lab-vnet"
  resource_group_name = "rg-lab"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]

  subnets = {
    default = { address_prefix = "10.0.1.0/24" }
    apps    = { address_prefix = "10.0.2.0/24" }
  }
}
```
