#!/usr/bin/env bash

set -e

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if is_installed node; then
		info "[Node.js] Already installed"
		return
	fi

	info "[Node.js] Install"
	curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
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
