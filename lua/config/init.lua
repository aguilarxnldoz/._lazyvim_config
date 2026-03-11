require("config.keymaps")
  
vim.o.termguicolors = true
vim.o.guifont = "JetBrains Mono:h14"
vim.opt.number = true

require("onedarkpro").setup({
  theme = "onedark_dark",
})

vim.cmd("colorscheme onedark_dark")

-- Keep background transparent even after :colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
    vim.cmd("highlight LineNr ctermbg=NONE guibg=NONE")
    vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE")
    vim.cmd("highlight EndOfBuffer ctermbg=NONE guibg=NONE")
  end,
})

local function set_nvim_tree_folder_icon_white()
  -- Force folder icons to white (re-apply after nvim-tree/theme updates)
  local white = { fg = "#ffffff", ctermfg = "White" }
  vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", white)
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", white)
  vim.api.nvim_set_hl(0, "NvimTreeClosedFolderIcon", white)
end

local function set_nvim_tree_folder_text_orange()
  -- Folder names (including opened/current)
  local white = { fg = "#ffffff", ctermfg = "White" }
  vim.api.nvim_set_hl(0, "NvimTreeFolderName", white)
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", white)
  vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", white)
  vim.api.nvim_set_hl(0, "NvimTreeSymlinkFolderName", white)
  vim.api.nvim_set_hl(0, "NvimTreeRootFolder", white)
end

vim.api.nvim_create_autocmd({ "ColorScheme", "FileType" }, {
  pattern = { "*", "NvimTree" },
  callback = function(ev)
    if ev.event == "ColorScheme" or ev.match == "NvimTree" then
      set_nvim_tree_folder_icon_white()
      set_nvim_tree_folder_text_orange()
    end
  end,
})

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "onedarkpro",
  },
  sections = {
    lualine_a = {
      {
        "filename",
        path = 1,
      },
    },
  },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- show diagnostics inline (virtual text) similar to VSCode
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- show absolute line numbers
-- (left as default; enable if you want with `vim.opt.number = true`)
