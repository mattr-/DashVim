return {
  -- mini.icons for fancy icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- nui is used by a bunch of other things
  { "MunifTanjim/nui.nvim", lazy = true },

  -- tokyonight will be the default color scheme
  { "folke/tokyonight.nvim", lazy = true },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
  },
}
