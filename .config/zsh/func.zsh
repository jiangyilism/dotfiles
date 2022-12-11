function extract() {
	local filepath="${1}"

	if [[ -f "${filepath}" ]]; then
		case "${filepath}" in
		*.tar.bz2) tar xvjf "${filepath}" ;;
		*.tar.gz) tar xvzf "${filepath}" ;;
		*.tar.xz) tar xvJf "${filepath}" ;;
		*.tar.lzma) tar --lzma xvf "${filepath}" ;;
		*.bz2) bunzip "${filepath}" ;;
		*.rar) unrar "${filepath}" ;;
		*.gz) gunzip "${filepath}" ;;
		*.tar) tar xvf "${filepath}" ;;
		*.tbz2) tar xvjf "${filepath}" ;;
		*.tgz) tar xvzf "${filepath}" ;;
		*.zip) unzip "${filepath}" ;;
		*.Z) uncompress "${filepath}" ;;
		*.7z) 7z x "${filepath}" ;;
		*) echo "'${filepath}' file type unsupported" ;;
		esac
	else
		echo "'${filepath}' is not a file"
	fi
}
