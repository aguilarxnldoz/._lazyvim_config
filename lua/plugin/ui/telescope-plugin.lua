return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        selection_caret = "▍ ",
        path_display = { "truncate" },
      },
      themes = {
        dropdown = {
          selection_caret = "▍ ",
        },
      },
    })

    vim.api.nvim_create_autocmd({ "ColorScheme", "BufAdd", "FileType" }, {
      pattern = "TelescopePrompt",
      callback = function()
        vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#ffffff", bg = "#333333" })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "TelescopeSelectionExtra", { fg = "#ffffff" })
      end,
    })

    pcall(telescope.load_extension, "fzf")

    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
  end,
}
