# Virtual Machine Module

Creates Azure Linux and/or Windows Virtual Machines with optional public IPs.

## Usage

```hcl
module "vms" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/virtual-machine?ref=v1.0.0"

  resource_group_name = "rg-lab"
  location            = "eastus"

  vms = {
    vm-linux = {
      subnet_id        = module.network.subnet_ids["default"]
      size             = "Standard_B2s"
      os_type          = "linux"
      admin_username   = "azureuser"
      ssh_public_key   = file("~/.ssh/id_rsa.pub")
      create_public_ip = true
    }
  }
}
```
