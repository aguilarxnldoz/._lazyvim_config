return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local crimson = "#DC143C"
    local function filename_component()
      return {
        "filename",
        path = 1,
        color = { bg = crimson },
      }
    end

    local function location_component()
      return {
        "location",
        color = { bg = crimson },
      }
    end

    local function clock_component()
      return {
        function()
          return os.date("%H:%M:%S")
        end,
        color = { bg = crimson },
      }
    end

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
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = { "mode", filename_component() },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { location_component(), clock_component() },
      },
    })
  end,
}
