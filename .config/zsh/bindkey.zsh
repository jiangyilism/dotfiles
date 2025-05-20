function dirstack_shift() {
	setopt localoptions nopushdminus

	if [[ ${#dirstack} -eq 0 ]]; then
		return
	fi

	while ! builtin pushd -q "${1}" &>/dev/null; do
		builtin popd -q "${1}"

		if [[ ${#dirstack} -eq 0 ]]; then
			break
		fi
	done

	zle reset-prompt
}

function dirstack_shift_left() {
	dirstack_shift "+1"
}

function dirstack_shift_right() {
	dirstack_shift "-0"
}

function goto_parent_dir() {
	cd ..
	zle reset-prompt
}

function expand_dollar_underscore() {
	emulate -L zsh

	if [[ "${LBUFFER: -2}" = "\$_" ]]; then
		zle backward-delete-char
		zle backward-delete-char
		zle insert-last-word
	fi

	zle magic-space
}

function insert_sudo() {
	emulate -L zsh

	if [[ -z "${BUFFER}" ]]; then
		zle up-history
	fi

	if [[ "${BUFFER}" != sudo\ * ]]; then
		BUFFER="sudo ${BUFFER} "
	fi

	zle end-of-line
}

function pipe_to_pager() {
	emulate -L zsh
	BUFFER="${BUFFER} |& \${PAGER}"
	zle end-of-line
}

function reset_term() {
	emulate -L zsh
	zle kill-whole-line
	tput reset
	zle reset-prompt
}

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" delete-word
bindkey "^H" backward-delete-word
bindkey "^U" backward-kill-line

zle -N dirstack_shift_left && bindkey "^[[1;3C" dirstack_shift_left
zle -N dirstack_shift_right && bindkey "^[[1;3D" dirstack_shift_right
zle -N expand_dollar_underscore && bindkey " " expand_dollar_underscore
zle -N goto_parent_dir && bindkey "^[[1;3A" goto_parent_dir
zle -N insert_sudo && bindkey "^[s" insert_sudo && bindkey "\e\e" insert_sudo
zle -N pipe_to_pager && bindkey "^[p" pipe_to_pager
zle -N reset_term && bindkey "^l" reset_term
