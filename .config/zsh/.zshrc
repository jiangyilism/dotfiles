if [[ ! -o interactive ]]; then
	return
fi

unset skip_global_compinit

if command -v starship &>/dev/null; then
	eval "$(starship init zsh)"
else
	echo "Missing starship"
fi

. "${ZDOTDIR:h}/shell/interactive.sh"

for zsh_file in setopt completion bindkey func hook history; do
	. "${ZDOTDIR}/${zsh_file}.zsh"
done

unset zsh_file

export WORDCHARS="_-"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

for plugin in ${plugins}; do
	if [[ -f "/usr/share/zsh/site-functions/${plugin}.zsh" ]]; then
		. "/usr/share/zsh/site-functions/${plugin}.zsh"
	elif [[ -f "/usr/share/zsh/site-contrib/${plugin}/${plugin}.zsh" ]]; then
		. "/usr/share/zsh/site-contrib/${plugin}/${plugin}.zsh"
	elif [[ -f "/usr/share/${plugin}/${plugin}.zsh" ]]; then
		. "/usr/share/${plugin}/${plugin}.zsh"
	else
		echo "Plugin ${plugin} not found"
	fi
done

unset plugin
