# Resource Group Module

Creates an Azure Resource Group.

## Usage

```hcl
module "rg" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/resource-group?ref=v1.0.0"

  name     = "rg-lab"
  location = "eastus"
}
```
