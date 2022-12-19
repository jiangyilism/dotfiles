if [[ ! -o interactive ]]; then
	return
fi

unset skip_global_compinit

if command -v starship &>/dev/null; then
	eval "$(starship init zsh)"
fi

. "${ZDOTDIR:h}/shell/interactive.sh"

for zsh_file in setopt completion bindkey func hook history; do
	. "${ZDOTDIR}/${zsh_file}.zsh"
done

unset zsh_file

export WORDCHARS="_-"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

for plugin in ${plugins}; do
	if [[ -f "/usr/share/zsh/site-functions/${plugin}/${plugin}.zsh" ]]; then
		. "/usr/share/zsh/site-functions/${plugin}/${plugin}.zsh"
	else
		. "/usr/share/${plugin}/${plugin}.zsh"
	fi
done

unset plugin
