return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "DaikyXendo/nvim-material-icon" },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    require("nvim-tree").setup({
      view = { side = "right" },
      filters = { custom = { ".DS_Store" } },
      git = { enable = true, ignore = false, timeout = 400 },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = { hint = "H", info = "I", warning = "W", error = "E" },
      },
      renderer = {
        highlight_git = true,
        icons = { show = { git = true, diagnostics = true } },
      },
    })

    local oasis_palette = require("oasis.palette")
    local nvim_tree_colors = {
      folder = oasis_palette.red[500],
      git_add = oasis_palette.terminal.bright_green,
      git_change = oasis_palette.terminal.bright_yellow,
      git_delete = oasis_palette.terminal.bright_red,
      git_ignored = oasis_palette.stone[600],
    }

    local function set_nvim_tree_folder_icon_highlights()
      local color = { fg = nvim_tree_colors.folder }
      vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", color)
      vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", color)
      vim.api.nvim_set_hl(0, "NvimTreeClosedFolderIcon", color)
    end

    local function set_nvim_tree_folder_text_highlights()
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

      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticError", { link = "DiagnosticError" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarn", { link = "DiagnosticWarn" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfo", { link = "DiagnosticInfo" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHint", { link = "DiagnosticHint" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorIcon", { link = "DiagnosticError" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnIcon", { link = "DiagnosticWarn" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoIcon", { link = "DiagnosticInfo" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintIcon", { link = "DiagnosticHint" })
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

    vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
  end,
}
