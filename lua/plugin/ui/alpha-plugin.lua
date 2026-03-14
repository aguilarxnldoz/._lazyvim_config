return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")

    local ok_palette, oasis_palette = pcall(require, "oasis.palette")
    local number_color = "#ff6b6b"
    local bracket_color = "#ffffff"
    local mru_color = "#8b8b8b"

    if ok_palette then
      number_color = oasis_palette.red[500] or number_color
      bracket_color = oasis_palette.white or oasis_palette.stone[200] or bracket_color
      mru_color = oasis_palette.stone[400] or mru_color
    end

    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#DC143C" })
    dashboard.section.header.opts.hl = "AlphaHeader"

    vim.api.nvim_set_hl(0, "AlphaNumber", { fg = number_color })
    vim.api.nvim_set_hl(0, "AlphaBracket", { fg = bracket_color })
    vim.api.nvim_set_hl(0, "AlphaMru", { fg = mru_color })

    dashboard.section.header.opts.position = "center"

    local function set_section_center(section)
      section.opts = section.opts or {}
      section.opts.inherit = vim.tbl_extend("force", section.opts.inherit or {}, { position = "center" })
    end

    local function shortcut_hl(shortcut)
      local left_bracket = shortcut:find("%[") or 1
      local right_bracket = shortcut:find("%]") or (#shortcut - 1)
      local left_index = left_bracket - 1
      local right_index = right_bracket - 1
      local number_start = left_index + 1
      local number_end = right_index

      if number_end < number_start then
        number_end = number_start
      end

      return {
        { "AlphaBracket", left_index, left_index + 1 },
        { "AlphaNumber", number_start, number_end },
        { "AlphaBracket", right_index, right_index + 1 },
      }
    end

    local function apply_shortcut_hl(el)
      if type(el) ~= "table" then
        return
      end

      if el.type == "button" then
        el.opts = el.opts or {}
        if el.opts.shortcut and #el.opts.shortcut > 0 then
          el.opts.hl_shortcut = shortcut_hl(el.opts.shortcut)
        end
        return
      end

      if type(el.val) == "table" then
        for _, item in ipairs(el.val) do
          apply_shortcut_hl(item)
        end
      end
    end

    local function button_display_width(button)
      if type(button) ~= "table" or button.type ~= "button" then
        return 0
      end

      local opts = button.opts or {}
      local shortcut = opts.shortcut or ""
      local text = button.val or ""
      return vim.fn.strdisplaywidth(shortcut .. text)
    end

    local function normalize_button_width(el)
      if type(el) ~= "table" then
        return
      end

      local buttons = {}
      local function collect(node)
        if type(node) ~= "table" then
          return
        end
        if node.type == "button" then
          table.insert(buttons, node)
          return
        end
        if type(node.val) == "table" then
          for _, item in ipairs(node.val) do
            collect(item)
          end
        end
      end

      collect(el)

      local max_width = 0
      for _, button in ipairs(buttons) do
        max_width = math.max(max_width, button_display_width(button))
      end

      if max_width == 0 then
        return
      end

      for _, button in ipairs(buttons) do
        button.opts = button.opts or {}
        button.opts.width = max_width
      end
    end

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.mru_cwd.val[2].opts.hl = "AlphaMru"
    dashboard.section.mru.val[2].opts.hl = "AlphaMru"

    set_section_center(dashboard.section.top_buttons)
    set_section_center(dashboard.section.bottom_buttons)
    set_section_center(dashboard.section.mru)
    set_section_center(dashboard.section.mru_cwd)

    apply_shortcut_hl(dashboard.section.top_buttons)
    apply_shortcut_hl(dashboard.section.bottom_buttons)
    normalize_button_width(dashboard.section.top_buttons)
    normalize_button_width(dashboard.section.bottom_buttons)

    local function mru_with_centered_shortcuts(start, cwd)
      local mru_group = dashboard.mru(start, cwd)
      mru_group.opts = mru_group.opts or {}
      mru_group.opts.inherit = vim.tbl_extend("force", mru_group.opts.inherit or {}, { position = "center" })
      apply_shortcut_hl(mru_group)
      normalize_button_width(mru_group)
      return mru_group
    end

    dashboard.section.mru.val[4].val = function()
      return { mru_with_centered_shortcuts(10) }
    end

    dashboard.section.mru_cwd.val[4].val = function()
      return { mru_with_centered_shortcuts(0, vim.fn.getcwd()) }
    end

    alpha.setup(dashboard.opts)
  end,
}
