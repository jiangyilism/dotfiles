mkdir --parents "${XDG_CACHE_HOME}/zsh"

autoload -Uz compinit

compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

zstyle ':completion:::::default' menu yes select
