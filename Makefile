#! /usr/bin/make 


SHELL := /bin/bash
VALID_ENVS := $(shell ls requirements_*.txt | grep -v lock | sed 's/requirements_\(.*\).txt/\1/')

.PHONY: help
help:  ## Print the help documentation
	@grep -E '^[a-zA-Z_-]+.*?:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
	@echo "Valid env names: $(VALID_ENVS)"
	@echo


.PHONY: validate-envs
validate-envs:
	@if [ -z "$(env)" ]; then \
		echo "Please run with 'make <target> env=<env-name>'   where <env-name> is one of: $(VALID_ENVS)" >&2; \
		exit 1; \
	fi

	@echo $(VALID_ENVS) | grep -qw $(env) || (echo "Error: Invalid env '$(env)'. Choose from: $(VALID_ENVS)" >&2; exit 1)

.PHONY: lock
lock: validate-envs ## Create lock file:  make lock env=<env-name>
	-rm  requirements_$(env).lock
	uv pip compile requirements_$(env).txt -o requirements_$(env).lock


.PHONY: install
install: validate-envs ## Create environment from lockfile: make install env=<env-name>
	-rm -rf $(env)
	uv venv ./$(env)
	. ./$(env)/bin/activate && uv pip install -r requirements_$(env).lock

.PHONY: nuke
nuke: ## Delete all evironments
	$(foreach env,$(VALID_ENVS),(rm -rf $(env) || 1);)




# 	-rm -rf $(env)
# 	uv venv ./$(env)
# 	. ./$(env)/bin/activate
# 	uv pip install -r requirements_$(env).lock
