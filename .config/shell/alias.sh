alias apt='sudo apt'
alias chmod='chmod --verbose'
alias chown='chown --verbose'
alias code='code -g'
alias cp='cp --interactive --verbose'
alias dd='dd status=progress'
alias df='df --human-readable --local --exclude-type="tmpfs"'
alias diff='diff --color=auto'
alias du='du --human-readable'
alias dmesg='sudo dmesg -T'
alias du='du --human-readable'
alias eix-sync='sudo eix-sync'
alias emerge='sudo emerge'
alias free='free --human --total'
alias fstrim='sudo fstrim --verbose'
alias grep='grep --color=auto --exclude-dir=.git --binary-files=without-match --line-number'
alias ip='ip -color=auto'
alias ln='ln --interactive --verbose'
alias lspci='sudo lspci'
alias mkdir='mkdir --verbose'
alias mount='sudo mount --verbose'
alias mv='mv --interactive --verbose'
alias open='xdg-open'
alias poweroff='sudo poweroff'
alias umount='sudo umount --verbose'
alias uname='uname --all'
alias updatedb='sudo updatedb'
alias reboot='sudo reboot'
alias reset='tput reset'
alias rm='rm --interactive --verbose'
alias su='su --shell=${SHELL} -'
alias sudo='sudo '
alias systemctl='sudo systemctl'
alias tree='tree -C'
alias type='type -a'

command -v batcat &>/dev/null && alias bat='batcat'
command -v bat &>/dev/null && alias cat='bat --paging=never --tabs=8'

if command -v exa &>/dev/null; then
	alias ls='exa --color=auto --all --sort=Name --across --classify'
	alias ll='ls --long'
else
	alias ls='ls --color=auto --almost-all --classify --human-readable'
	alias ll='ls -l'
fi

function vim() {
	local filepath

	for filepath in "${@}"; do
		if [[ "${filepath}" = -* ]] || [[ ! -e "${filepath}" ]]; then
			continue
		fi

		if [[ ! -w "${filepath}" ]]; then
			echo "sudo vim ${@}"
			return
		fi
	done

	if command -v nvim &>/dev/null; then
		nvim "${@}"
	else
		vim "${@}"
	fi
}

function cd() {
	builtin cd "${@}" && ls && echo -ne "\033]0;$(basename "${PWD}")\a"
}

