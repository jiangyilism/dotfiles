autoload -Uz add-zsh-hook

add-zsh-hook chpwd () {
	emulate -L zsh
	
	if [[ "${OLDPWD}" = "${PWD}" ]]; then
		return
	fi

	ls
	echo -ne "\033]0;$(basename "${PWD}")\a"
}
