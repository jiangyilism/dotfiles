#!/bin/bash

set -xueo pipefail

function assert_running_as_root() {
	if [[ "${EUID}" -ne 0 ]]; then
		sudo bash "${0}" "${@}"
		exit "${?}"
	fi
}

function apt_upgrade() {
	apt update --yes
	apt upgrade --yes
	apt dist-upgrade --yes
	apt autoremove --yes
	apt autoclean --yes
	apt remove --yes
	apt clean --yes
}

function emerge_upgrade() {
	eix-sync
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

function post_upgrade() {
	updatedb
}

function main() {
	assert_running_as_root

	if command -v apt &>/dev/null; then
		apt_upgrade
	fi

	if command -v emerge &>/dev/null; then
		emerge_upgrade
	fi

	post_upgrade
}

tput reset
main
