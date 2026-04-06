return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  config = function()
    local treesitter_opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "html", "css", "c_sharp" },
      highlight = { enable = true },
      indent = { enable = true },
    }

    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup(treesitter_opts)
    else
      require("nvim-treesitter").setup(treesitter_opts)
    end
  end,
}
