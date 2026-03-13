return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "html",
        "css",
        "c_sharp",
      },
      highlight = { enable = true, additional_vim_regex_highlighting = true },
      indent = { enable = true },
    })
  end,
}
