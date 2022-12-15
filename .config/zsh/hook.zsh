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
	if [[ "${1}" = "${3}" ]] || [[ -z "${3}" ]]; then
		return
	fi

	echo -e "\e[1;3;37m-------->>>>  ${3}\e[0m"
}
