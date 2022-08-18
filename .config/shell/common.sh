alias apt='sudo apt'
alias code='code -g'
alias df='df --human-readable --local --exclude-type="tmpfs"'
alias dmesg='dmesg -T'
alias du='du --human-readable'
alias free='free --human --total'
alias fstrim='sudo fstrim --verbose'
alias grep='grep --color=auto --exclude-dir=.git --binary-files=without-match --line-number'
alias ll='ls -l --classify --human-readable'
alias ls='ls --color=auto --all'
alias lspci='sudo lspci'
alias mount='sudo mount'
alias open='xdg-open'
alias poweroff='sudo poweroff'
alias umount='sudo umount'
alias updatedb='sudo updatedb'
alias reboot='sudo reboot'
alias reset='tput reset'

function dates() {
	for timezone in Asia/Saigon Asia/Taipei Europe/Berlin; do
		printf "%-18s " "${timezone}"
		TZ="${timezone}" date
	done
}

function toolchain_env_clear() {
	unset CXX
	unset CC
	unset AR
	unset RANLIB
	unset CFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset LSAN_OPTIONS
	unset UBSAN_OPTIONS
	unset CMAKE_BUILD_PARALLEL_LEVEL
	unset CMAKE_EXPORT_COMPILE_COMMANDS
	unset CMAKE_GENERATOR
}

function toolchain_env_setup() {
	export CFLAGS="-O2 -march=native -pipe -Wall -Wextra -Wmissing-declarations -Wnull-dereference -Wredundant-decls -Wshadow"
	export CXXFLAGS="${CFLAGS} -Wctor-dtor-privacy -Wnon-virtual-dtor -Wold-style-cast -Wzero-as-null-pointer-constant"
	export LDFLAGS="-Wl,-O2 -Wl,--as-needed"
	export LSAN_OPTIONS="verbosity=1:log_threads=1"
	export UBSAN_OPTIONS="print_stacktrace=1"
	export CMAKE_BUILD_PARALLEL_LEVEL="$(($(nproc) - 1))"
	export CMAKE_EXPORT_COMPILE_COMMANDS=ON
	#export CMAKE_GENERATOR="Ninja"
	export CMAKE_GENERATOR="Unix Makefiles"
}

function gcc_env_setup() {
	local -r toolchain_dir="$(dirname $(which gcc))"

	if [[ ! -d "${toolchain_dir}" ]]; then
		echo "no gcc found"
		return 1
	fi

	export CXX="${toolchain_dir}/g++"
	export CC="${toolchain_dir}/gcc"
	export AR="${toolchain_dir}/gcc-ar"
	export RANLIB="${toolchain_dir}/gcc-ranlib"

	toolchain_env_setup
}

function clang_env_setup() {
	local -r toolchain_dir="$(dirname $(which clang))"

	if [[ ! -d "${toolchain_dir}" ]]; then
		echo "no clang found"
		return 1
	fi

	export CXX="${toolchain_dir}/clang++"
	export CC="${toolchain_dir}/clang"
	export AR="${toolchain_dir}/llvm-ar"
	export RANLIB="${toolchain_dir}/llvm-ranlib"

	toolchain_env_setup
}

function cd() {
	if [[ -n "${1}" ]]; then
		builtin cd "$@" && ls
	else
		builtin cd "${HOME}" && ls
	fi
}

function extract() {
	local -r archive="${1}"

	case "${archive}" in
	*.tar.bz2)
		tar xvjf "${archive}"
		;;
	*.tar.gz)
		tar xvzf "${archive}"
		;;
	*.bz2)
		bunzip2 "${archive}"
		;;
	*.rar)
		rar x "${archive}"
		;;
	*.gz)
		gunzip "${archive}"
		;;
	*.tar)
		tar xvf "${archive}"
		;;
	*.tbz2)
		tar xvjf "${archive}"
		;;
	*.tgz)
		tar xvzf "${archive}"
		;;
	*.zip)
		unzip "${archive}"
		;;
	*.Z)
		uncompress "${archive}"
		;;
	*.7z)
		7z x "${archive}"
		;;
	*)
		echo "don't know how to extract ${archive} ..."
		;;
	esac
}

function weather() {
  local -r location="${1:-Stuttgart}"

  curl "wttr.in/${location}"
}

export PS4='+\e[90m$(basename ${BASH_SOURCE}):${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}: }\e[0m'

cmd_timestamp_file="/tmp/${USER}.${$}.cmd_timestamp"
cmd_exe_time_file="/tmp/${USER}.${$}.cmd_exe_time"
trap 'rm -f ${cmd_timestamp_file} ${cmd_exe_time_file}' EXIT

function seconds_to_str() {
	local -r total_sec="${1:-0}"
	local -r sec=$((total_sec % 60))
	local -r min=$(((total_sec / 60) % 60))
	local -r hour=$(((total_sec / 3600) % 60))
	local -r day=$(((total_sec / 86400)))

	[[ "${day}" -gt 0 ]] && printf '%dd' "${day}"
	[[ "${hour}" -gt 0 ]] && printf '%02dh' "${hour}"
	[[ "${min}" -gt 0 ]] && printf '%02dm' "${min}"
	printf '%02ds' "${sec}"
}

function time_elapsed_since() {
	local -r timestamp0="$(date +'%D %H:%M:%S')"
	local -r timestamp1="${1}"
	local -r sec0="$(date -d "${timestamp0}" +%s)"
	local -r sec1="$(date -d "${timestamp1}" +%s)"

	echo $(seconds_to_str $((sec0 - sec1)))
}

function prompt_command() {
	local -r exit_code=${?}

	if [[ -f "${cmd_exe_time_file}" ]]; then
		cat "${cmd_exe_time_file}"
		return
	fi

	local -r prev_timestamp="$(cut -d' ' -f2 "${cmd_timestamp_file}")"
	local -r cur_timestamp="$(date +%H:%M:%S)"

	printf "\e[01;$((${exit_code}==0 ? 32 : 31))m\n----[%s - %s | exe time: %s | exit code: %03d]----\e[0m\n" ${prev_timestamp} ${cur_timestamp} $(time_elapsed_since "$(< ${cmd_timestamp_file})") ${exit_code} | tee ${cmd_exe_time_file}
}

function start_cmd_timer() {
  date +'%D %H:%M:%S' > "${cmd_timestamp_file}"
  rm -f "${cmd_exe_time_file}"
}

export PATH="${PATH}:${HOME}/git_utils"

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

if [[ -f "${HOME}/.shrc_additional" ]]; then
	. "${HOME}/.shrc_additional"
fi
