autoload -Uz add-zsh-hook

add-zsh-hook chpwd () {
	emulate -L zsh
	
	if [[ "${OLDPWD}" = "${PWD}" ]]; then
		return
	fi

	ls
	echo -ne "\033]0;$(basename "${PWD}")\a"
}

add-zsh-hook preexec () {
	local -r trimmed_input="${1//+([[:space:]])}"
	local -r trimmed_expanded_input="${3//+([[:space:]])}"

	if [[ "${trimmed_input}" = "${trimmed_expanded_input}" ]] ||
		[[ -z "${trimmed_expanded_input}" ]]; then
		return
	fi

	echo -e "\e[1;3;37m-------->>>>  ${3}\e[0m"
}
