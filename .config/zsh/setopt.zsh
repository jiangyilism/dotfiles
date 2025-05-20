setopt no_beep
unsetopt flow_control

# directory
setopt auto_pushd
setopt pushd_ignore_dups

# completion
setopt always_to_end
setopt complete_in_word
unsetopt auto_menu
unsetopt menu_complete

# correction
setopt correct
setopt correctall

# glob
setopt extended_glob
setopt glob_dots
setopt ksh_glob
setopt mark_dirs

# history

setopt append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history #Immediately append to the history file, not just when a term is killed
#setopt sharehistory         #Share history across terminals

# shell
setopt sh_word_split
