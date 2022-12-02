
source "$HOME/.config/shell/aliases.sh"

stty -ixon

export PS4='+\e[90m$(basename ${BASH_SOURCE}):${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}: }\e[0m'

export PATH="$PATH:$HOME/.local/bin"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$XDG_CACHE_HOME/runtime"

export CONAN_USER_HOME="$XDG_CONFIG_HOME"
export GDBHISTFILE="$XDG_CACHE_HOME/gdb/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export LESSHISTFILE="/dev/null"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="most"

mkdir --parents "$XDG_CACHE_HOME/gdb" \
	"$XDG_CONFIG_HOME/python" \
	"$XDG_CONFIG_HOME/readline/inputrc" \
	"$XDG_DATA_HOME/tig" \
	"$XDG_RUNTIME_DIR"

test -f "$HOME/.shrc_additional" && source "$HOME/.shrc_additional"
:

