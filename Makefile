# Azure Terraform Modules - Common Tasks
# ========================================
# Usage: make <target> [MODULE=<module_name>]
# Example: make validate MODULE=network

MODULES := resource-group virtual-network network-security-group network-hub-spoke virtual-machine log-analytics-workspace azure-firewall
MODULE ?=

.PHONY: help fmt validate lint docs test clean

help:
	@echo "Azure Terraform Modules - Available targets:"
	@echo ""
	@echo "  fmt       - Format Terraform files in all modules"
	@echo "  validate  - Validate Terraform configuration (MODULE=name for single module)"
	@echo "  lint      - Run TFLint on modules (MODULE=name for single module)"
	@echo "  docs      - Generate Terraform docs for all modules"
	@echo "  test      - Run validation on all modules"
	@echo "  clean     - Remove .terraform directories and lock files"
	@echo ""
	@echo "Examples:"
	@echo "  make fmt"
	@echo "  make validate MODULE=network"
	@echo "  make test"

fmt:
	@echo "==> Formatting Terraform files..."
	@terraform fmt -recursive .

validate:
	@if [ -n "$(MODULE)" ]; then \
		echo "==> Validating module: $(MODULE)..."; \
		cd modules/$(MODULE) && terraform init -backend=false && terraform validate && cd ../..; \
	else \
		for mod in $(MODULES); do \
			echo "==> Validating module: $$mod..."; \
			cd modules/$$mod && terraform init -backend=false && terraform validate && cd ../.. || exit 1; \
		done; \
	fi

lint:
	@if command -v tflint >/dev/null 2>&1; then \
		if [ -n "$(MODULE)" ]; then \
			echo "==> Linting module: $(MODULE)..."; \
			cd modules/$(MODULE) && tflint --init && tflint && cd ../..; \
		else \
			for mod in $(MODULES); do \
				echo "==> Linting module: $$mod..."; \
				cd modules/$$mod && tflint --init && tflint && cd ../.. || exit 1; \
			done; \
		fi \
	else \
		echo "TFLint not installed. Install: brew install tflint"; \
	fi

docs:
	@if command -v terraform-docs >/dev/null 2>&1; then \
		echo "==> Generating documentation..."; \
		for mod in $(MODULES); do \
			echo "  - $$mod"; \
			terraform-docs -c .terraform-docs.yml modules/$$mod; \
		done; \
	else \
		echo "terraform-docs not installed. Install: brew install terraform-docs"; \
	fi

test: fmt validate
	@echo "==> All checks passed!"

clean:
	@echo "==> Cleaning Terraform artifacts..."
	@find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	@find . -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	@echo "Done."
