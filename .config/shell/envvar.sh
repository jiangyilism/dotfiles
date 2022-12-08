
export PATH=$(echo -n "${HOME}/.local/bin${PATH:+:${PATH}}" | \
	awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')

export PS4='+\e[90m$(basename ${BASH_SOURCE}):\e[1;36m$(printf "%3d" ${LINENO})\e[90m:$(printf "%-8s" ${FUNCNAME[0]:+${FUNCNAME[0]}: })\e[0m'

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_DIR="${XDG_CACHE_HOME}/runtime"

export CONAN_USER_HOME="${XDG_CONFIG_HOME}"
export GDBHISTFILE="${XDG_CACHE_HOME}/gdb/history"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export LESSHISTFILE="/dev/null"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

type nvim &> /dev/null && export EDITOR="nvim" \
	|| export EDITOR="vim"

export VISUAL="${EDITOR}"

type most &> /dev/null && export PAGER="most" \
	|| export PAGER="less"

