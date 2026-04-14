return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local terminal_red = "#ff5555"
    local treesitter_red = terminal_red
    local crimson = terminal_red

    local lualine_theme = vim.deepcopy(require("lualine.themes.oasis"))
    local modes = { "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }
    for _, mode in ipairs(modes) do
      if lualine_theme[mode] and lualine_theme[mode].b then
        lualine_theme[mode].b.fg = treesitter_red
      end
      if lualine_theme[mode] and lualine_theme[mode].c then
        lualine_theme[mode].c.fg = treesitter_red
      end
    end

    local function right_side_component(component)
      local spec = type(component) == "table" and vim.deepcopy(component) or { component }
      spec.color = vim.tbl_extend("force", spec.color or {}, { fg = treesitter_red })
      return spec
    end

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
          return "🕒 " .. os.date("%I:%M:%S %p")
        end,
        color = { bg = crimson },
      }
    end

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = lualine_theme,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode", filename_component() },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = {
          right_side_component("encoding"),
          right_side_component({ "fileformat", symbols = { unix = "", mac = "" } }),
          right_side_component("filetype"),
        },
        lualine_y = { right_side_component("progress") },
        lualine_z = { location_component(), clock_component() },
      },
      tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
