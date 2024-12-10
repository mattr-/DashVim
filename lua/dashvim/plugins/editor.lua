return {
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- telescope doesn't do releases
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git)" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- ensure that telescope always uses the first window that's a file for opening
        -- a new file. This will help prevent it from taking over a plugin
        -- window (think neo-tree, trouble or copilot chat)
        get_selection_window = function()
          local windows = vim.api.nvim_list_wins()
          table.insert(windows, 1, vim.api.nvim_get_current_win())
          for _, window in ipairs(windows) do
            local buf = vim.api.nvim_win_get_buf(window)
            if vim.bo[buf].buftype == "" then
              return window
            end
          end
          return 0
        end,
      },
    },
  },
}
