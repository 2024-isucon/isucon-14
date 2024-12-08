.PHONY: help build
.DEFAULT_GOAL := help

help: ## Check available make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Run the deployment script
	branch=${branch} ./scripts/deploy.sh

setting-nginx: ## Setting up nginx
	./scripts/setting-nginx.sh
