# Log Analytics Workspace Module

Creates an Azure Log Analytics workspace for centralized logging and monitoring.

## Usage

```hcl
module "log_analytics_workspace" {
  source = "git::https://github.com/your-org/azure-terraform-modules//modules/log-analytics-workspace?ref=v1.0.0"

  name                = "law-lab"
  resource_group_name = "rg-lab"
  location            = "eastus"
  retention_in_days   = 30
}
```
