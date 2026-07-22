function _print_git_alias_expansion() {
	local -r cmd="${1}"
	local -r subcommand="${2}"

	if [[ -n "${subcommand}" ]]; then
		local -r alias_value=$(command git config "alias.${subcommand}" 2>/dev/null)

		if [[ -n "${alias_value}" && "${alias_value}" != '!'* ]]; then
			local -r rest="${@:3}"

			echo -e "\e[1;3;37m-------->>>>  ${cmd} ${alias_value}${rest:+  ${rest}}\e[0m"
		fi
	fi
}

function git() {
	_print_git_alias_expansion git "$@"
	command git "$@"
}

function yadm() {
	_print_git_alias_expansion yadm "$@"
	command yadm "$@"
}

function extract() {
	local -r filepath="${1}"

	if [[ ! -f "${filepath}" ]]; then
		echo "'${filepath}' is not a file"
		return
	fi

	local -r dirname="${filepath%%.*}"

	if [[ -e "${dirname}" ]]; then
		echo "'${dirname}' already exists"
		return
	else
		mkdir --verbose "${dirname}"
	fi

	case "${filepath}" in
	*.tar.bz2) tar xvjf "${filepath}" -C "${dirname}" ;;
	*.tar.gz) tar xvzf "${filepath}" -C "${dirname}" ;;
	*.tar.xz) tar xvJf "${filepath}" -C "${dirname}" ;;
	*.tar.lzma) tar --lzma xvf "${filepath}" -C "${dirname}" ;;
	*.bz2) bunzip "${filepath}" ;;
	*.rar) unrar x "${filepath}" "${dirname}" ;;
	*.gz) gunzip "${filepath}" ;;
	*.tar) tar xvf "${filepath}" -C "${dirname}" ;;
	*.tbz2) tar xvjf "${filepath}" -C "${dirname}" ;;
	*.tgz) tar xvzf "${filepath}" -C "${dirname}" ;;
	*.zip) unzip "${filepath}" -d "${dirname}" ;;
	*.Z) uncompress "${filepath}" ;;
	*.7z) 7z x "${filepath}" -o "${dirname}" ;;
	*) echo "'${filepath}' file type unsupported" ;;
	esac
}
