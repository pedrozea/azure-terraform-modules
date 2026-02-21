# Network Hub-Spoke Module

Creates a hub-and-spoke network topology with VNet peering. Ideal for lab and production deployments with centralized services (firewall, VPN) in the hub and workloads in spokes.

## Usage

```hcl
module "network_hub_spoke" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/network-hub-spoke?ref=v1.0.0"

  hub_vnet_name       = "hub-vnet"
  resource_group_name = "rg-lab"
  location            = "eastus"
  hub_address_space   = "10.0.0.0/16"

  hub_subnets = {
    AzureFirewallSubnet = { address_prefix = "10.0.1.0/26" }
    GatewaySubnet       = { address_prefix = "10.0.2.0/27" }
  }

  spokes = {
    spoke1 = {
      name          = "spoke-apps"
      address_space = "10.1.0.0/16"
      subnets = {
        default = { address_prefix = "10.1.1.0/24" }
      }
    }
    spoke2 = {
      name          = "spoke-data"
      address_space = "10.2.0.0/16"
      subnets = {
        default = { address_prefix = "10.2.1.0/24" }
      }
    }
  }
}
```
