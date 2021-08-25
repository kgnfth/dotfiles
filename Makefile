.DEFAULT_GOAL := all

.PHONY: help
help: ## Display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: git pkg bat fzf nodejs rvm ruby zsh ohmyzsh colorls ## Install and configure everything (default)

.PHONY: pkg-install
pkg-install: ## Install Ubuntu packages
	@./scripts/pkg.sh install

.PHONY: pkg
pkg: pkg-install ## pkg-install

.PHONY: git-install
git-install: ## Install git
	@./scripts/git.sh install

.PHONY: git-configure
git-configure: ## Configure git
	@./scripts/git.sh configure

.PHONY: git
git: git-install git-configure ## git-install git-configure

.PHONY: bat-install
bat-install: ## Install bat
	@./scripts/bat.sh install

.PHONY: bat-configure
bat-configure: ## Configure bat
	@./scripts/bat.sh configure

.PHONY: bat
bat: bat-install bat-configure ## bat-install bat-configure

.PHONY: fzf-install
fzf-install: ## Install fzf
	@./scripts/fzf.sh install

.PHONY: fzf
fzf: fzf-install ## fzf-install

.PHONY: zsh-install
zsh-install: ## Install zsh
	@./scripts/zsh.sh install

.PHONY: zsh-configure
zsh-configure: ## Configure zsh
	@./scripts/zsh.sh configure

.PHONY: zsh
zsh: zsh-install zsh-configure ## zsh-install zsh-configure

.PHONY: ohmyzsh-install
ohmyzsh-install: ## Install Oh My Zsh
	@./scripts/ohmyzsh.sh install

.PHONY: ohmyzsh-configure
ohmyzsh-configure: ## Configure Oh My Zsh
	@./scripts/ohmyzsh.sh configure

.PHONY: ohmyzsh
ohmyzsh: ohmyzsh-install ohmyzsh-configure ## ohmyzsh-install ohmyzsh-configure

.PHONY: rvm-install
rvm-install: ## Install rvm
	@./scripts/rvm.sh install

.PHONY: rvm
rvm: rvm-install ## rvm-install

.PHONY: ruby-install
ruby-install: ## Install ruby using rm
	@./scripts/ruby.sh install

.PHONY: ruby
ruby: ruby-install ## ruby-install

.PHONY: colorls-install
colorls-install: ## Install colorls
	@./scripts/colorls.sh install

.PHONY: colorls-configure
colorls-configure: ## Configure colorls
	@./scripts/colorls.sh configure

.PHONY: colorls
colorls: colorls-install colorls-configure ## colorls-install colorls-configure

.PHONY: nodejs-install
nodejs-install: ## Install nodejs
	@./scripts/nodejs.sh install

.PHONY: nodejs
nodejs: nodejs-install ## nodejs-install
