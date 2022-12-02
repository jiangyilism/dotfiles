#!/bin/bash

set -xueo pipefail

function assert_running_as_root() {
	if [[ "${EUID}" -ne 0 ]]; then
		echo "Need root permission"
		exit 1
	fi
}

function apt_upgrade() {
	apt update -y
	apt upgrade -y
	apt dist-upgrade -y
	apt autoremove -y
	apt autoclean -y
	apt remove -y
	apt clean -y
	updatedb
}

function emerge_upgrade() {
	emerge --verbose \
		--ask \
		--deep \
		--changed-use \
		--newuse \
		--changed-deps=y \
		--with-bdeps=y \
		--update \
		@world
}

function main() {
	assert_running_as_root

	if command -v apt &> /dev/null; then
		apt_upgrade
	elif command -v emerge &> /dev/null; then
		emerge_upgrade
	else
		echo "unsupported package manager. quitting now."
		exit 0
	fi
}

tput reset
main
