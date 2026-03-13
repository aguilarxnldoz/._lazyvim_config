return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters = {
        prettier = {
          prepend_args = {
            "--use-tabs",
            "--tab-width",
            "4",
            "--print-width",
            "250",
            "--no-bracket-spacing",
            "--single-attribute-per-line",
            "--embedded-language-formatting",
            "off",
          },
        },
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    })

    vim.keymap.set("n", "<leader>fm", function()
      require("conform").format({ lsp_fallback = true })
    end, { desc = "Format" })
  end,
}
