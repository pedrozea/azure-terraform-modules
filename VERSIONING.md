# Versioning and Release Strategy

This document defines the Semantic Versioning (SemVer) strategy, release process, and how to consume versioned modules from other projects.

## Overview

This repository uses **single-repo versioning**: one version applies to the entire repository. When you tag `v1.2.0`, all modules at that commit share that version. Consumers reference specific versions via Git tags.

## Semantic Versioning (SemVer)

Format: `MAJOR.MINOR.PATCH` (e.g., `v1.2.3`)

| Bump | When | Examples |
|------|------|----------|
| **MAJOR** | Breaking changes to any module's interface | Remove/rename variable or output, change variable type, remove module |
| **MINOR** | New features, backward compatible | New optional variable, new output, new module |
| **PATCH** | Bug fixes, docs, internal changes | Fix bug, improve description, refactor without interface change |

### Interface Definition

A module's **interface** is its public contract:
- **Inputs**: `variables.tf` (name, type, optional vs required)
- **Outputs**: `outputs.tf` (name, value)

Any change that forces consumers to modify their configuration is **breaking**.

## Release Process

### 1. Make Changes on a Branch

```bash
git checkout -b feature/my-change
# ... edit modules ...
git add .
git commit -m "feat(virtual-network): add support for service endpoints"
```

### 2. Update CHANGELOG.md

Before releasing, add an entry under `[Unreleased]`:

```markdown
## [Unreleased]

### Added
- virtual-network: support for service endpoints on subnets
```

### 3. Merge to main

```bash
git checkout main
git merge feature/my-change
git push origin main
```

### 4. Create a Release

**Bump version and tag:**

```bash
# Ensure you're on main and up to date
git checkout main
git pull origin main

# 1. Update CHANGELOG.md:
#    - Rename [Unreleased] to [X.Y.Z] and add today's date
#    - Add new empty [Unreleased] section for next release
#
# 2. Commit and tag
git add CHANGELOG.md
git commit -m "chore: release v1.1.0"
git tag -a v1.1.0 -m "Release v1.1.0"

# 3. Push branch and tag
git push origin main
git push origin v1.1.0
```

Pushing a tag matching `v*.*.*` triggers the release workflow, which creates a GitHub Release with the full CHANGELOG.

## Consuming from Another Repository

### Reference by Tag

Always pin to a specific version tag:

```hcl
module "virtual_network" {
  source = "git::https://github.com/YOUR_ORG/azure-terraform-modules//modules/virtual-network?ref=v1.0.0"

  name                = "my-vnet"
  resource_group_name = "rg-example"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]
  subnets             = { ... }
}
```

Replace `YOUR_ORG` with your GitHub org/username. Use HTTPS or SSH:

```hcl
# SSH
source = "git::ssh://git@github.com/YOUR_ORG/azure-terraform-modules//modules/virtual-network?ref=v1.0.0"
```

### Git Source Limitations

- **No version ranges**: Terraform's Git source does not support `~>` or `>=`. You must use an exact `ref` (tag or commit).
- **Immutable tags**: Once pushed, do not move or delete tags. Treat them as immutable.

## Updating Modules in Consuming Projects

### Recommended Workflow

1. **Check CHANGELOG** in this repo for changes between your current version and the latest.
2. **Review breaking changes** (MAJOR bumps). Plan migration steps.
3. **Update `ref`** in your project's `module` blocks:

   ```hcl
   # Before
   source = "...?ref=v1.0.0"

   # After (e.g., patch update)
   source = "...?ref=v1.0.1"
   ```

4. **Run `terraform init -upgrade`** to fetch the new module version:

   ```bash
   terraform init -upgrade
   ```

5. **Plan and apply**:

   ```bash
   terraform plan
   terraform apply
   ```

### Update Cadence

| Change Type | Recommendation |
|-------------|----------------|
| PATCH | Update when convenient; low risk |
| MINOR | Update within 1–2 sprints to get new features |
| MAJOR | Plan migration; test in non-production first |

## Changelog Maintenance

We follow [Keep a Changelog](https://keepachangelog.com/). Each release section should include:

- **Added** – New features, optional variables
- **Changed** – Changes in existing behavior (backward compatible)
- **Deprecated** – Soon-to-be removed features
- **Removed** – Removed features (breaking)
- **Fixed** – Bug fixes
- **Security** – Security fixes

Group entries by module when relevant:

```markdown
### Added
- virtual-network: optional `service_endpoints` variable
### Fixed
- azure-firewall: correct SKU default for Premium tier
```

## Checklist for Contributors

Before merging changes that affect module interfaces:

- [ ] Variable/output changes documented in CHANGELOG
- [ ] Breaking changes justified and migration path described
- [ ] Examples updated if module usage changed
- [ ] `make test` passes

## Checklist for Releases

- [ ] CHANGELOG updated with all changes since last release
- [ ] Version bumped per SemVer rules
- [ ] Tag created and pushed
- [ ] GitHub Release created (optional, with notes from CHANGELOG)
