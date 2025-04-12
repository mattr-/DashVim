return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      -- diagnostic config is here because LSP is the main user of diagnostics
      ---@type vim.diagnostic.Opts
      diagnostics = {
        -- underlines for warnings and errors only
        underline = { severity = vim.diagnostic.severity.WARN },
        -- use neovim 0.11's new virtual_lines
        virtual_lines = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = DashVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = DashVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = DashVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = DashVim.config.icons.diagnostics.Info,
          },
        },
      },
      -- inlay hints are enabled by default but we leave a hook here for folks
      -- to disable them. Needs to be supported by the LSP server and properly
      -- configured.
      inlay_hints = {
        enabled = true,
      },
      -- codelens is enabled by default but we leave a hook here for folks
      -- to disable it. Needs to be supported by the LSP server and properly
      -- configured.
      codelens = {
        enabled = true,
      },
      -- Snacks has rename support, so define some global capabilities to
      -- augment the defaults
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- Define a way for folks to define custom server config settings when adding language support
      lsp_servers = {
      },
      -- Define hooks for customizing server setup. Mostly useful for when you want to bypass lspconfig
      -- for a separate language specific plugin. Rather than setting up language specific handlers,
      -- a key in this table for an lsp server will be used.
      custom_server_setup = {
      },
    },
    config = function(_, opts)
      -- setup neovim's diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- Merge blink's capabilities with neovim's built in capabilities
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )
      local lsp_servers = opts.lsp_servers
      function custom_server_config(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, lsp_servers[server] or {})

        if opts.custom_server_setup[server] then
          if opts.custom_server_setup(server, server_opts) then
            return
          end
        elseif opts.custom_server_setup["*"] then
          if opts.custom_server_setup(server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local have_mlsp_config, mlsp = pcall(require, "mason-lspconfig")
      local mason_lsp_servers = {}
      if have_mlsp_config then
        mason_lsp_servers = vim.tbl_keys(mlsp.get_mappings().lspconfig_to_mason)
      end

      local lsp_ensure_installed = {} ---@type string[]
      for server, server_options in pairs(lsp_servers) do
        server_options = server_options == true and {} or server_options
        -- if this server isn't available via mason or has been set to not be installed via mason
        -- then set it up manually. otherwise let mason install it
        if server_options.use_mason == false or not vim.tbl_contains(mason_lsp_servers, server) then
          custom_server_config(server)
        else
          lsp_ensure_installed[#lsp_ensure_installed + 1] = server
        end
      end

      if have_mlsp_config then
        mlsp.setup({
          ensure_installed = lsp_ensure_installed,
          handlers = { custom_server_config },
        })
      end
    end,
  },

  -- UI and Tooling for installing formatters, linters, and LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>vm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Auto completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    ---@type blink.cmp.Config
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    opts = {
    },
  },

}
