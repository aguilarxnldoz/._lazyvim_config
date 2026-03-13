return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "oasis",
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            "filename",
            path = 1,
          },
        },
      },
      tabline = {
        lualine_a = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_z = {
          function()
            return os.date("%H:%M:%S")
          end,
        },
      },
    })
  end,
}
