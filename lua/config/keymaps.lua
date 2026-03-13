vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = false

vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==")
vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==")
