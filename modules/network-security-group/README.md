# Network Security Group Module

Creates an Azure Network Security Group with configurable rules and optional subnet associations.

## Usage

```hcl
module "nsg" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/network-security-group?ref=v1.0.0"

  name                = "lab-nsg"
  resource_group_name = "rg-lab"
  location            = "eastus"

  security_rules = {
    allow-ssh = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  subnet_ids = [module.virtual_network.subnet_ids["default"]]
}
```
