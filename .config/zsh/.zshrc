if [[ ! -o interactive ]]; then
	return
fi

. "${ZDOTDIR:h}/shell/interactive.sh"

for zsh_file in setopt bindkey completion func hook history; do
	. "${ZDOTDIR}/${zsh_file}.zsh"
done

export WORDCHARS="_-"

if command -v starship &>/dev/null; then
	eval "$(starship init zsh)"
fi

. ${HOME}/Desktop/temp/zsh-autosuggestions.zsh
. ${HOME}/Desktop/temp/zsh-history-substring-search.zsh
. ${HOME}/Desktop/temp/zsh-syntax-highlighting.zsh
