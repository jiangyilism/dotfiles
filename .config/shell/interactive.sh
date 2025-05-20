. "${XDG_CONFIG_HOME}/shell/alias.sh"

stty -ixon

mkdir --parents "${XDG_CACHE_HOME}/gdb" \
	"${XDG_CONFIG_HOME}/python" \
	"${XDG_DATA_HOME}/tig" \
	"${XDG_RUNTIME_DIR}"

function set_win_title() {
	echo -ne "\033]0;$(basename "${PWD}")\a"
}

if [[ -f "${HOME}/.shrc_extra.sh" ]]; then
	. "${HOME}/.shrc_extra.sh"
fi
