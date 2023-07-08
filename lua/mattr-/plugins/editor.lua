return {
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- telescope doesn't do releases
    cmd = "Telescope",
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        -- ["g"] = { name = "+goto" },
        -- ["gz"] = { name = "+surround" },
        -- ["]"] = { name = "+next" },
        -- ["["] = { name = "+prev" },
        -- ["<leader><tab>"] = { name = "+tabs" },
        -- ["<leader>b"] = { name = "+buffer" },
        -- ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
         ["<leader>g"] = { name = "+git" },
        -- ["<leader>gh"] = { name = "+hunks" },
        -- ["<leader>q"] = { name = "+quit/session" },
        -- ["<leader>s"] = { name = "+search" },
        -- ["<leader>u"] = { name = "+ui" },
        -- ["<leader>w"] = { name = "+windows" },
        -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
