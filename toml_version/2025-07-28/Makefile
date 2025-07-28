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