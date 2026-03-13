require("config.keymaps")
  
vim.o.termguicolors = true
vim.o.guifont = "JetBrains Mono:h14"
vim.opt.number = true

require("oasis").setup({
  style = "abyss",
  themed_syntax = true,
  transparent = false,
  highlight_overrides = {
    Normal = { fg = "#c0caf5" },
    Comment = { fg = "#4d526b", italic = true },
    String = { fg = "#9ece6a" },
    Character = { fg = "#9ece6a" },
    Number = { fg = "#e08f68" },
    Boolean = { fg = "#e08f68" },
    Float = { fg = "#e08f68" },
    Constant = { fg = "#e08f68" },
    Identifier = { fg = "#f7768e" },
    Function = { fg = "#7aa2f7" },
    Statement = { fg = "#bb9af7" },
    Keyword = { fg = "#bb9af7" },
    Conditional = { fg = "#bb9af7" },
    Repeat = { fg = "#bb9af7" },
    Label = { fg = "#bb9af7" },
    Operator = { fg = "#7dcfff" },
    PreProc = { fg = "#bb9af7" },
    Include = { fg = "#bb9af7" },
    Define = { fg = "#bb9af7" },
    Macro = { fg = "#bb9af7" },
    Type = { fg = "#dec76e" },
    StorageClass = { fg = "#bb9af7" },
    Structure = { fg = "#dec76e" },
    Typedef = { fg = "#dec76e" },
    Special = { fg = "#7dcfff" },
    Delimiter = { fg = "#c0caf5" },
    Tag = { fg = "#f7768e" },

    ["@comment"] = { fg = "#4d526b", italic = true },
    ["@comment.documentation"] = { fg = "#4d526b", italic = true },
    ["@string"] = { fg = "#9ece6a" },
    ["@string.escape"] = { fg = "#7dcfff" },
    ["@string.regexp"] = { fg = "#7dcfff" },
    ["@character"] = { fg = "#9ece6a" },
    ["@number"] = { fg = "#e08f68" },
    ["@boolean"] = { fg = "#e08f68" },
    ["@constant"] = { fg = "#e08f68" },
    ["@constant.builtin"] = { fg = "#dec76e" },
    ["@constant.macro"] = { fg = "#bb9af7" },
    ["@variable"] = { fg = "#f7768e" },
    ["@variable.builtin"] = { fg = "#dec76e" },
    ["@variable.parameter"] = { fg = "#c0caf5" },
    ["@parameter"] = { fg = "#c0caf5" },
    ["@property"] = { fg = "#c0caf5" },
    ["@field"] = { fg = "#c0caf5" },
    ["@function"] = { fg = "#7aa2f7" },
    ["@function.builtin"] = { fg = "#7dcfff" },
    ["@function.method"] = { fg = "#7aa2f7" },
    ["@method"] = { fg = "#7aa2f7" },
    ["@constructor"] = { fg = "#7aa2f7" },
    ["@type"] = { fg = "#dec76e" },
    ["@type.builtin"] = { fg = "#dec76e" },
    ["@type.definition"] = { fg = "#dec76e" },
    ["@namespace"] = { fg = "#dec76e" },
    ["@module"] = { fg = "#dec76e" },
    ["@keyword"] = { fg = "#bb9af7" },
    ["@keyword.operator"] = { fg = "#7dcfff" },
    ["@keyword.return"] = { fg = "#bb9af7" },
    ["@keyword.function"] = { fg = "#bb9af7" },
    ["@keyword.conditional"] = { fg = "#bb9af7" },
    ["@keyword.repeat"] = { fg = "#bb9af7" },
    ["@operator"] = { fg = "#7dcfff" },
    ["@punctuation.delimiter"] = { fg = "#c0caf5" },
    ["@punctuation.bracket"] = { fg = "#c0caf5" },
    ["@punctuation.special"] = { fg = "#f7768e" },
    ["@tag"] = { fg = "#f7768e" },
    ["@tag.attribute"] = { fg = "#7dcfff", italic = true },

    ["@lsp.type.keyword"] = "@keyword",
    ["@lsp.type.operator"] = "@operator",
    ["@lsp.type.string"] = "@string",
    ["@lsp.type.number"] = "@number",
    ["@lsp.type.boolean"] = "@boolean",
    ["@lsp.type.comment"] = "@comment",
    ["@lsp.type.variable"] = "@variable",
    ["@lsp.type.parameter"] = "@parameter",
    ["@lsp.type.function"] = "@function",
    ["@lsp.type.method"] = "@method",
    ["@lsp.type.property"] = "@property",
    ["@lsp.type.class"] = "@type",
    ["@lsp.type.type"] = "@type",
    ["@lsp.type.enum"] = "@type",
    ["@lsp.type.enumMember"] = "@constant",
    ["@lsp.type.namespace"] = "@namespace",
  },
})

vim.o.background = "dark"
vim.cmd("colorscheme oasis-abyss")

local oasis_palette = require("oasis.palette")
local nvim_tree_colors = {
  folder = oasis_palette.red[500],
  git_add = oasis_palette.terminal.bright_green,
  git_change = oasis_palette.terminal.bright_yellow,
  git_delete = oasis_palette.terminal.bright_red,
  git_ignored = oasis_palette.stone[600],
}

local function set_nvim_tree_folder_icon_highlights()
  -- Set folder icons to Oasis Abyss red
  local color = { fg = nvim_tree_colors.folder }
  vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", color)
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", color)
  vim.api.nvim_set_hl(0, "NvimTreeClosedFolderIcon", color)
end

local function set_nvim_tree_folder_text_highlights()
  -- Set folder names to Oasis Abyss red
  local color = { fg = nvim_tree_colors.folder }
  vim.api.nvim_set_hl(0, "NvimTreeFolderName", color)
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", color)
  vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", color)
  vim.api.nvim_set_hl(0, "NvimTreeSymlinkFolderName", color)
  vim.api.nvim_set_hl(0, "NvimTreeRootFolder", color)
end

local function set_nvim_tree_git_and_diagnostic_highlights()
  local function set_groups(groups, opts)
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

  -- Git status colors (vivid)
  local git_add = { fg = nvim_tree_colors.git_add, bold = true }
  local git_change = { fg = nvim_tree_colors.git_change, bold = true }
  local git_delete = { fg = nvim_tree_colors.git_delete, bold = true }
  local git_ignored = { fg = nvim_tree_colors.git_ignored }

  set_groups({
    "NvimTreeGitDirty",
    "NvimTreeGitStaged",
    "NvimTreeGitRenamed",
    "NvimTreeGitMerge",
    "NvimTreeGitDirtyIcon",
    "NvimTreeGitStagedIcon",
    "NvimTreeGitRenamedIcon",
    "NvimTreeGitMergeIcon",
    "NvimTreeGitFileDirty",
    "NvimTreeGitFileStaged",
    "NvimTreeGitFileRenamed",
    "NvimTreeGitFileMerge",
    "NvimTreeGitFolderDirty",
    "NvimTreeGitFolderStaged",
    "NvimTreeGitFolderRenamed",
    "NvimTreeGitFolderMerge",
  }, git_change)

  set_groups({
    "NvimTreeGitNew",
    "NvimTreeGitNewIcon",
    "NvimTreeGitFileNew",
    "NvimTreeGitFolderNew",
  }, git_add)

  set_groups({
    "NvimTreeGitDeleted",
    "NvimTreeGitDeletedIcon",
    "NvimTreeGitFileDeleted",
    "NvimTreeGitFolderDeleted",
  }, git_delete)

  set_groups({
    "NvimTreeGitIgnored",
    "NvimTreeGitIgnoredIcon",
    "NvimTreeGitFileIgnored",
    "NvimTreeGitFolderIgnored",
  }, git_ignored)

  -- Diagnostics colors (file/dir icons)
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticError", { link = "DiagnosticError" })
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarn", { link = "DiagnosticWarn" })
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfo", { link = "DiagnosticInfo" })
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHint", { link = "DiagnosticHint" })

  -- Diagnostic icon highlights (some nvim-tree versions use these)
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorIcon", { link = "DiagnosticError" })
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnIcon", { link = "DiagnosticWarn" })
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoIcon", { link = "DiagnosticInfo" })
  vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintIcon", { link = "DiagnosticHint" })

  -- Legacy highlight groups (older nvim-tree versions)
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsError", { link = "DiagnosticError" })
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsWarning", { link = "DiagnosticWarn" })
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsInformation", { link = "DiagnosticInfo" })
  vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsHint", { link = "DiagnosticHint" })
end

vim.api.nvim_create_autocmd({ "ColorScheme", "FileType" }, {
  pattern = { "*", "NvimTree" },
  callback = function(ev)
    if ev.event == "ColorScheme" or ev.match == "NvimTree" then
      set_nvim_tree_folder_icon_highlights()
      set_nvim_tree_folder_text_highlights()
      set_nvim_tree_git_and_diagnostic_highlights()
    end
  end,
})

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "oasis",
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
