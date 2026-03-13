return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
  },
  {
    -- Drop-in replacement for nvim-web-devicons (material icon set)
    "DaikyXendo/nvim-material-icon",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        color_icons = true,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    config = function()
      require("nvim-tree").setup({
        view = { side = "right" },
      })
      vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
    end,
  },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "html", "css", "c_sharp" },
        highlight = { enable = true },
      })
    end,
  },
  {
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
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
    config = function()
      require("mason-conform").setup({
        ensure_installed = { "prettier" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "html", "cssls", "emmet_language_server", "vtsls", "omnisharp" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local cmp_lsp = require("cmp_nvim_lsp")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = cmp_lsp.default_capabilities(capabilities)

      vim.lsp.config.vtsls = {
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      }

      vim.lsp.config.html = { capabilities = capabilities }
      vim.lsp.config.cssls = { capabilities = capabilities }
      vim.lsp.config.emmet_language_server = {
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact" },
      }
      vim.lsp.config.omnisharp = { capabilities = capabilities }

      vim.lsp.enable({ "vtsls", "html", "cssls", "emmet_language_server", "omnisharp" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters = {
          prettier = {
            prepend_args = {
              "--use-tabs",
              "--tab-width",
              "4",
              "--print-width",
              "250",
              "--no-bracket-spacing",
              "--single-attribute-per-line",
              "--embedded-language-formatting",
              "off",
            },
          },
        },
        formatters_by_ft = {
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_fallback = true,
        },
      })

      vim.keymap.set("n", "<leader>fm", function()
        require("conform").format({ lsp_fallback = true })
      end, { desc = "Format" })
    end,
  },
  -- Tag matching and visual indent guides
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
      -- show offscreen matches in a popup and enable surround matching
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_surround_enabled = 1
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("indent_blankline").setup {
        char = "│",
        show_current_context = true,
        show_current_context_start = true,
        buftype_exclude = { "terminal" },
        filetype_exclude = { "help", "terminal", "dashboard" },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = { enable = true },
      })
      require("nvim-ts-autotag").setup {}
    end,
  },
}
