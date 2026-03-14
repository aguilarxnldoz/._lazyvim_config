return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>zk",
      function()
        require("flash").jump()
      end,
      mode = { "n", "x", "o" },
      desc = "Flash jump",
    },
  },
}
