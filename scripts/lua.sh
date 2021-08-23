#!/usr/bin/env bash

set -e

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

LUA_VERSION="${LUA_VERSION:=5.3.5}"
LUAROCKS_VERSION="${LUAROCKS_VERSION:=3.3.1}"

do_install() {
	if [[ "$(lua -v 2>/dev/null)" == *"${LUA_VERSION}"* ]]; then
		info "[lua] ${LUA_VERSION} already installed"
		return
	fi

	info "[lua] Install"
	local lua="lua-${LUA_VERSION}"
	local target="/tmp/${lua}.tar.gz"
	cd /tmp
	download_to "${target}" http://www.lua.org/ftp/${lua}.tar.gz
	tar -xzf "${target}"
	cd "${lua}"
	make linux test
	sudo make install

	if [[ "$(luarocks --version 2>/dev/null)" == *"${LUAROCKS_VERSION}"* ]]; then
		info "[luarocks] ${LUAROCKS_VERSION} already installed"
		return
	fi

	info "[luarocks] Install"
	local luarocks="luarocks-${LUAROCKS_VERSION}"
	local target="/tmp/${luarocks}.tar.gz"
	download_to "${target}" http://www.luarocks.org/releases/${luarocks}.tar.gz
	cd /tmp
	tar -xzf "${target}"
	cd "${luarocks}"
	./configure --with-lua-include=/usr/local/include
	make
	sudo make install
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
