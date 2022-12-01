if [[ ! -o interactive ]]; then
	return
fi

. "${HOME}/.config/shell/common.sh"

#setopt sharehistory         #Share history across terminals
setopt appendhistory        #Append history to the history file (no overwriting)
setopt auto_param_slash
setopt globdots
setopt hist_ignore_dups
setopt inc_append_history   #Immediately append to the history file, not just when a term is killed
setopt mark_dirs
setopt sh_word_split

unsetopt auto_menu
unsetopt menu_complete

mkdir --parents "${XDG_STATE_HOME}/zsh" "${XDG_CACHE_HOME}/zsh"

export HISTDUP=erase
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export HISTSIZE=1024
export SAVEHIST=2048

compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

if command -v starship &>/dev/null; then
	eval "$(starship init zsh)"
fi

