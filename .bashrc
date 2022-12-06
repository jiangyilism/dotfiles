if [[ ! "${-}" = *i* ]]; then
	return
fi

. "${HOME}/.config/shell/common.sh"

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

if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
fi

