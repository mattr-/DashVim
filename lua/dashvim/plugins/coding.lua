return {
  -- Blink for completions
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
      "sources.providers",
    },
    event = "InsertEnter",
    opts = {
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
        -- providers = {
        --   lazydev = {
        --     name = "LazyDev",
        --     module = "lazydev.integrations.blink",
        --     score_offset = 100, --higher priority than lsp
        --   },
        -- },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    opts = {
      local types = require("luasnip.util.types")
      return {
        history = true,
        delete_check_events = "TextChanged",
        ext_opts = {
          [types.choiceNode] = {
            active = { virt_text = {{ "●", require("catppuccin.palettes").get_palette("mocha")["pink"] }} }
          },
        },
      }
    }

  },
}
