return {
  "neovim/nvim-lspconfig",
  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_lsp.default_capabilities(capabilities)

    vim.lsp.config.vtsls = {
      capabilities = capabilities,
      filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    }

    vim.lsp.config.html = { capabilities = capabilities }
    vim.lsp.config.cssls = { capabilities = capabilities }
    vim.lsp.config.emmet_language_server = {
      capabilities = capabilities,
      filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact" },
    }
    vim.lsp.config.omnisharp = { capabilities = capabilities }

    vim.lsp.enable({ "vtsls", "html", "cssls", "emmet_language_server", "omnisharp" })

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
  end,
}
