
vim.o.tabstop = 8

vim.wo.colorcolumn = "80,100"
vim.wo.number = true

vim.api.nvim_command([[
autocmd BufNewFile *.sh 0r ~/.config/nvim/skeletons/bash.sh
]])
