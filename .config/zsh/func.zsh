function extract() {
	local -r filepath="${1}"

	if [[ ! -f "${filepath}" ]]; then
		echo "'${filepath}' is not a file"
		return
	fi

	local -r dirname="${filepath%%.*}"

	if [[ -e "${dirname}" ]]; then
		echo "'${dirname}' already exists"
		return
	else
		mkdir --verbose "${dirname}"
	fi

	case "${filepath}" in
	*.tar.bz2) tar xvjf "${filepath}" -C "${dirname}" ;;
	*.tar.gz) tar xvzf "${filepath}" -C "${dirname}" ;;
	*.tar.xz) tar xvJf "${filepath}" -C "${dirname}" ;;
	*.tar.lzma) tar --lzma xvf "${filepath}" -C "${dirname}" ;;
	*.bz2) bunzip "${filepath}" ;;
	*.rar) unrar x "${filepath}" "${dirname}" ;;
	*.gz) gunzip "${filepath}" ;;
	*.tar) tar xvf "${filepath}" -C "${dirname}" ;;
	*.tbz2) tar xvjf "${filepath}" -C "${dirname}" ;;
	*.tgz) tar xvzf "${filepath}" -C "${dirname}" ;;
	*.zip) unzip "${filepath}" -d "${dirname}" ;;
	*.Z) uncompress "${filepath}" ;;
	*.7z) 7z x "${filepath}" -o "${dirname}" ;;
	*) echo "'${filepath}' file type unsupported" ;;
	esac
}
