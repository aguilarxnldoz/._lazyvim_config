require("config.keymaps")

vim.o.termguicolors = true
vim.o.guifont = "JetBrains Mono:h14"
vim.opt.number = true

require("config.tokyogogh-foreground").setup()

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})
