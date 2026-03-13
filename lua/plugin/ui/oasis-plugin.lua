return {
  "uhs-robert/oasis.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("oasis").setup({
      style = "abyss",
      themed_syntax = true,
      transparent = false,
    })

    vim.o.background = "dark"
    vim.cmd("colorscheme oasis-abyss")
  end,
}
