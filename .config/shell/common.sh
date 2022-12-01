
source "$HOME/.config/shell/aliases.sh"

stty -ixon

export PS4='+\e[90m$(basename ${BASH_SOURCE}):${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}: }\e[0m'

export PATH="$PATH:$HOME/git_utils"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export GDBHISTFILE="$XDG_CACHE_HOME/gdb/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

export EDITOR="vim"
export VISUAL="vim"
export PAGER="most"

mkdir --parents "$XDG_CACHE_HOME/gdb" "$XDG_CACHE_HOME/less" "$XDG_CONFIG_HOME/python"

test -f "$HOME/.shrc_additional" && source "$HOME/.shrc_additional"

