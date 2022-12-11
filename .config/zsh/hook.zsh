autoload -Uz add-zsh-hook

add-zsh-hook chpwd () {
	emulate -L zsh
	ls
	echo -ne "\033]0;$(basename "${PWD}")\a"
}
