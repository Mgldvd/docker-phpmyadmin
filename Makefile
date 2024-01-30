#!make
include .env
export $(shell sed 's/=.*//' .env)

SHELL := /bin/bash

.SILENT: test up stop pull update rebuild remove
.PHONY: test up stop pull update rebuild remove
# .RECIPEPREFIX +=
# .RECIPEPREFIX := $(.RECIPEPREFIX)

help:
	@grep -E '^[1-9a-zA-Z_-]+:.*?## .*$$|(^#--)' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m %-24s\033[0m %s\n", $$1, $$2}' \
	| sed -e 's/\[32m #-- /[33m/'

#--
#--  Docker Apps

up: ## Run container
	docker compose up -d
	@echo
	@echo -e "\033[1;33m▍ ▸ \033[0mphpmyadmin: http://localhost:${GUI_PORT}\033[0m"
	@echo

stop: ## Stop container
	docker compose stop

down: ## Remove contanier
	docker compose stop
	docker compose rm -f
	docker compose down --remove-orphans

restart: ## Remove and run container
	docker compose stop
	docker compose rm -f
	docker compose down --remove-orphans
	docker compose up -d

url: ## Show url
	@echo
	@echo -e "\033[1;33m▍ ▸ \033[0mphpmyadmin: http://localhost:${GUI_PORT}\033[0m"
	@echo
