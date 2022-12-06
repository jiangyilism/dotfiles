
vim.api.nvim_command([[
autocmd BufNewFile *.sh 0r ~/.config/nvim/skeletons/bash.sh
]])

vim.o.colorcolumn = "80,100"
vim.o.number = true
vim.o.tabstop = 8

vim.opt.whichwrap:append "<>[]"

