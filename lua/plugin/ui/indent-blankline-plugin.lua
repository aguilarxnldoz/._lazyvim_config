return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
  opts = {
    indent = { char = "│" },
    scope = { enabled = true, show_start = true, show_end = true },
    exclude = {
      filetypes = { "help", "terminal", "dashboard" },
      buftypes = { "terminal" },
    },
  },
}
