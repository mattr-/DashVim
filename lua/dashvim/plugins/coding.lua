return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    build = (not jit.os:find("Windows"))
      and "echo 'NOTE: Installing optional jsregexp. Build failures are ok.' ; make install_jsregexp"
      or nil,
    opts = function()
      local types = require("luasnip.util.types")
      return {
        keep_roots = true,
        link_roots = true,
        link_children = true,
        exit_roots = false,
        update_events = { "TextChanged", "TextChangedI", "InsertLeave" },
        delete_check_events = "TextChanged",
        ext_opts = {
          [types.choiceNode] = {
            active = { virt_text = {{ "󱊅 ", "Special" }} }
          },
        },
      }
    end,
    keys = {
      {
        "<C-j>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        mode = { "i", "s" },
        desc = "Next LuaSnip Choice",
      },
      {
        "<C-k>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then
            ls.change_choice(-1)
          end
        end,
        mode = { "i", "s" },
        desc = "Next LuaSnip Choice",
      },
    },
  },
}
