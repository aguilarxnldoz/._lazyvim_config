return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "html", "cssls", "emmet_language_server", "vtsls", "omnisharp" },
    })
  end,
}
