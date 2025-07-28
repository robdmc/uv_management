#! /usr/bin/make

SHELL := /bin/bash

.PHONY: help
help:  ## Print the help documentation
	@grep -E '^[a-zA-Z_-]+.*?:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

.PHONY: new
new: ## Create new dated environment from latest (overwrites if exists)
	@LATEST=$$(ls -1d 20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] 2>/dev/null | tail -1); \
	TODAY=$$(date +%Y-%m-%d); \
	if [ -z "$$LATEST" ]; then echo "No existing environments found"; exit 1; fi; \
	if [ "$$LATEST" = "$$TODAY" ]; then \
		echo "Latest environment is already today ($$TODAY). No action needed."; \
		echo "Run 'cd $$TODAY && uv sync' to set up the environment"; \
		exit 0; \
	fi; \
	rm -rf "$$TODAY"; \
	mkdir -p "$$TODAY"; \
	cp "$$LATEST/Makefile" "$$TODAY/"; \
	cp "$$LATEST/pyproject.toml" "$$TODAY/"; \
	cp -r "$$LATEST/ai" "$$TODAY/"; \
	if [ -f "$$LATEST/ad_hoc_installs.txt" ]; then \
		cp "$$LATEST/ad_hoc_installs.txt" "$$TODAY/"; \
	else \
		touch "$$TODAY/ad_hoc_installs.txt"; \
	fi; \
	echo "Created new environment: $$TODAY"; \
	echo "Run 'cd $$TODAY && uv sync' to set up the environment"