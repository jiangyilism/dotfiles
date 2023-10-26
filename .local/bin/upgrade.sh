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
	apt full-upgrade --yes
	apt autoremove --yes
	apt autoclean --yes
	apt remove --yes
	apt clean --yes
}

function emerge_upgrade() {
	eix-sync
	emerge --verbose \
		--ask=y \
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

	local -r distro_name="$(lsb_release --id --short)"

	case "${distro_name}" in
		Gentoo)
			emerge_upgrade
			;;
		Ubuntu)
			apt_upgrade
			;;
		*)
			echo "Unsupported distro ${distro_name}"
			;;
	esac

	post_upgrade
}

tput reset
main
