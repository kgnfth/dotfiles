#!/usr/bin/env bash

set -e

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	local packages=(
		build-essential
		cmake
		curl
		dconf-cli
		htop
		libreadline-dev
		moreutils
		tree
		units
		unrar
		unzip
	)

	info "[pkg] Install"
	export DEBIAN_FRONTEND=noninteractive
	sudo apt update
	sudo apt install -y "${packages[@]}"
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
