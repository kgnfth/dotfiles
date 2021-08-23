#!/usr/bin/env bash

set -e

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

NVM_DIR="${HOME}/.nvm"
NVM_VERSION="${NVM_VERSION:=0.34.0}"

do_install() {
	if [[ -f "${NVM_DIR}/nvm.sh" ]]; then
		info "[nvm] ${NVM_VERSION} already installed"
		return
	fi

	info "[nvm] Install ${NVM_VERSION}"
	mkdir -p "${NVM_DIR}"
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
}

main() {
	command=$1
	case $command in
	"install")
		shift
		do_install "$@"
		;;
	*)
		error "$(basename "$0"): '$command' is not a valid command"
		;;
	esac
}

main "$@"
