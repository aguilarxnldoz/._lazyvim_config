local ok_ts, configs = pcall(require, "nvim-treesitter.configs")
if ok_ts then
  configs.setup {
    ensure_installed = { "html", "javascript", "typescript", "tsx", "css" },
    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
  }
end

-- matchup settings (redundant if set in plugin config but safe to have here)
vim.g.matchup_matchparen_offscreen = { method = "popup" }
vim.g.matchup_surround_enabled = 1

-- indent-blankline is configured by plugin entry; this file centralizes UI settings

return {}
