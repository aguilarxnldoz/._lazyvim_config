return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          extra_args = {
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
        }),
      },
    })

    local function format_with_none_ls(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()

      local has_none_ls = false
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if (client.name == "null-ls" or client.name == "none-ls") and client.supports_method("textDocument/formatting") then
          has_none_ls = true
          break
        end
      end

      if not has_none_ls then
        return
      end

      vim.lsp.buf.format({
        bufnr = bufnr,
        timeout_ms = 2000,
        filter = function(client)
          return client.name == "null-ls" or client.name == "none-ls"
        end,
      })
    end

    vim.keymap.set("n", "<leader>fm", function()
      format_with_none_ls()
    end, { desc = "Format" })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        format_with_none_ls(args.buf)
      end,
    })
  end,
}
