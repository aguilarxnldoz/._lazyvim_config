return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "html", "css", "c_sharp" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
