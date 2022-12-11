alias apt='sudo apt'
alias blkid='grc blkid'
alias chmod='chmod --verbose'
alias chown='chown --verbose'
alias code='code -g'
alias cp='cp --interactive --verbose'
alias curl='grc curl'
alias dd='dd status=progress'
alias df='grc df --human-readable --local --exclude-type="tmpfs"'
alias diff='diff --color=auto'
alias du='grc du --human-readable'
alias dmesg='sudo dmesg -T'
alias du='du --human-readable'
alias eix-sync='sudo eix-sync'
alias emerge='sudo emerge'
alias free='grc free --human --total'
alias fstrim='sudo fstrim --verbose'
alias grep='grep --color=auto --exclude-dir=.git --binary-files=without-match --line-number'
alias ifconfig='grc ifconfig -v'
alias ip='ip -color=auto'
alias less='${PAGER}'
alias ln='ln --interactive --verbose'
alias lsblk='grc lsblk'
alias lsmod='grc lsmod'
alias lsof='grc lsof'
alias lspci='grc lspci'
alias mkdir='mkdir --verbose'
alias mount='sudo grc mount --verbose'
alias mv='mv --interactive --verbose'
alias netstat='grc netstat'
alias open='xdg-open'
alias ping='grc ping'
alias ping6='grc ping6'
alias poweroff='sudo poweroff'
alias ps='grc ps'
alias umount='sudo umount --verbose'
alias uname='uname --all'
alias updatedb='sudo updatedb'
alias reboot='sudo reboot'
alias reset='tput reset'
alias rm='rm --interactive --verbose'
alias stat='grc stat'
alias su='su --shell=${SHELL} -'
alias sudo='sudo '
alias systemctl='sudo systemctl'
alias type='type -a'

if command -v batcat &>/dev/null; then
	alias bat='batcat'
fi

if command -v bat &>/dev/null; then
	alias cat='bat --paging=never --tabs=8'
fi

if command -v exa &>/dev/null; then
	alias ls='exa --color=auto --all --sort=Name --across --classify'
	alias ll='ls --long'
	alias tree='exa --tree'
else
	alias ls='ls --color=auto --almost-all --classify --human-readable'
	alias ll='ls -l'
	alias tree='tree -C'
fi

if command -v grc &>/dev/null; then
	alias grc='grc --colour=auto'
else
	alias grc=''
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
