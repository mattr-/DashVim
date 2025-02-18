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
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- noice for ui customization
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline",
        ---@type table<string, CmdlineFormat>
        format = {
          -- fix icons with new nerd fonts
          search_down = { kind = "search", pattern = "^/", icon = "󱁴 ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "󱁴 ", lang = "regex" },
        },
      },
      popupmenu = {
        enabled = false,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d+ more line" },
              { find = "%d+ fewer line" },
              { find = "%d lines?" },
              { find = "Already at oldest change" },
              { find = "^E486" }, -- The couldn't find it error
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      -- { "<leader>vnl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      -- { "<leader>vnh", function() require("noice").cmd("history") end, desc = "Noice History" },
      -- { "<leader>vna", function() require("noice").cmd("all") end, desc = "Noice All" },
      -- { "<leader>vnd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      -- { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      -- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },
}
