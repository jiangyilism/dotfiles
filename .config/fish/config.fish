if not status is-interactive
        exit
end

source "$HOME/.config/shell/common.sh"

set fish_greeting

function __ls_after_cd --on-variable PWD
  ls
end

if command --query starship
        starship init fish | source
end
