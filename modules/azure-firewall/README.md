# Azure Firewall Module

Creates an Azure Firewall in a dedicated subnet (AzureFirewallSubnet, /26 minimum).

## Usage

```hcl
module "azure_firewall" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/azure-firewall?ref=v1.0.0"

  name                = "afw-lab"
  resource_group_name = "rg-lab"
  location            = "eastus"
  subnet_id           = module.network_hub_spoke.hub_subnet_ids["AzureFirewallSubnet"]

  network_rules = [
    {
      name                   = "allow-https"
      source_addresses       = ["*"]
      destination_ports      = ["443"]
      destination_addresses  = ["*"]
      protocols              = ["TCP"]
    }
  ]
}
```
