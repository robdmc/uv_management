#! /usr/bin/make 


SHELL := /bin/bash

.PHONY: help
help:  ## Print the help documentation
	@grep -E '^[a-zA-Z_-]+.*?:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
	@echo "Valid env names: $(VALID_ENVS)"
	@echo


.PHONY: env
env: ## Create an env for this project
	rm -rf .venv || true
	uv venv

.PHONY: lock
lock:  ## Create lock file
	uv lock

.PHONY: sync
sync: ## Installs lock file into env (creating lockfile if needed)
	uv sync

.PHONY: activate
activate: ## Activate the virtual environment
	exec bash --rcfile <(echo '. ~/.bashrc; source .venv/bin/activate; echo "Virtual environment activated"')

.PHONY: nuke
nuke: ## Delete the virtual environment
	rm -rf .venv || true

.PHONY: backup
backup: ## Create backup of pyproject.toml and uv.lock in named directory (usage: make backup name=dirname)
	@if [ -z "$(name)" ]; then \
		echo "Error: name parameter is required. Usage: make backup name=my_name"; \
		exit 1; \
	fi
	mkdir -p $(name)
	cp pyproject.toml $(name)/ || true
	cp uv.lock $(name)/ || true