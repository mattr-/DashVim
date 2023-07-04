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
}
