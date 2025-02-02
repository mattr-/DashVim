return {
  --catppuccin will be the default colorscheme
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {}
  },

  --mini.icons for filetype and other icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    version = false, --pull from main always
    opts = {},
    -- hook into the package loader to have mini.icons mock out
    -- nvim-web-devicons if something attempts to load nvim-web-devicons
  },
}
