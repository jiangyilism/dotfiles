. "${HOME}/.config/shell/env.sh"

if [[ ! "${-}" = *i* ]]; then
	return
fi

. "${XDG_CONFIG_HOME}/shell/interactive.sh"

shopt -s checkwinsize
shopt -s histappend

mkdir --parents "${XDG_STATE_HOME}/bash"

export HISTFILE="${XDG_STATE_HOME}/bash/history"
export HISTCONTROL=ignoreboth
export HISTFILESIZE=2048
export HISTSIZE=1024

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

bind -x '"\C-l":tput reset'

function cd() {
	builtin cd "${@}" && ls && echo -ne "\033]0;$(basename "${PWD}")\a"
}

if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
else
	echo "Missing starship"
fi

if command -v fzf &>/dev/null; then
	eval "$(fzf --bash)"
else
	echo "Missing fzf"
fi

