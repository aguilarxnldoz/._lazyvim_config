return {
  "DaikyXendo/nvim-material-icon",
  config = function()
    require("nvim-web-devicons").setup({
      default = true,
      color_icons = true,
    })
  end,
}
