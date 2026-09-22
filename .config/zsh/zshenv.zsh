if [[ -n "${AI_AGENT}" ]]; then
	echo "Do not run zsh without explicit permission from human users"
	exit 1
fi

export ZDOTDIR="${$(print -P %N):h}"

. "${ZDOTDIR:h}/shell/env.sh"

skip_global_compinit=1
