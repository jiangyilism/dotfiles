export ZDOTDIR="${$(print -P %N):h}"

. "${ZDOTDIR:h}/shell/env.sh"

skip_global_compinit=1
