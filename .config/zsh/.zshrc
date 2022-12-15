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

. ${HOME}/Desktop/temp/zsh-autosuggestions.zsh
. ${HOME}/Desktop/temp/zsh-history-substring-search.zsh
. ${HOME}/Desktop/temp/zsh-syntax-highlighting.zsh
