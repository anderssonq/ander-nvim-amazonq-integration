local M = {
  ---------------------------------------------------------------------------
  -- mason.nvim
  ---------------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  ---------------------------------------------------------------------------
  -- mason-lspconfig.nvim
  ---------------------------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          -- "vtsls", -- keep installed if you want, but it's not enabled below
          "html",
          "vue_ls", -- Vue 3 server name (matches mason-lspconfig)
        },
        -- We will call vim.lsp.enable() ourselves after configuring servers
        automatic_enable = false,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- nvim-lspconfig
  ---------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local configs     = require("lspconfig.configs")
      local util        = require("lspconfig.util")

      -----------------------------------------------------------------------
      -- Vue 3 (define vue_ls config if lspconfig doesn't ship it yet)
      -----------------------------------------------------------------------
      if not configs.vue_ls then
        configs.vue_ls = {
          default_config = {
            cmd = { "vue-language-server", "--stdio" },
            filetypes = { "vue" },
            root_dir = util.root_pattern(
              "package.json",
              "tsconfig.json",
              "jsconfig.json",
              ".git"
            ),
            init_options = {
              vue = {
                hybridMode = false,
              },
            },
            settings = {},
          },
        }
      end

      -----------------------------------------------------------------------
      -- Global defaults for all LSP clients
      -----------------------------------------------------------------------
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -----------------------------------------------------------------------
      -- TypeScript / JavaScript
      -----------------------------------------------------------------------
      vim.lsp.config("ts_ls", {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
        },
      })

      -----------------------------------------------------------------------
      -- Vue 3
      -----------------------------------------------------------------------
      vim.lsp.config("vue_ls", {
        -- add vue-specific settings here if you need them
      })

      -----------------------------------------------------------------------
      -- HTML
      -----------------------------------------------------------------------
      vim.lsp.config("html", {})

      -----------------------------------------------------------------------
      -- Lua
      -----------------------------------------------------------------------
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -----------------------------------------------------------------------
      -- LspAttach: buffer-local keymaps & other per-client setup
      -----------------------------------------------------------------------
      local group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- vim.keymap.set(
          --   "n",
          --   "<leader>lf",
          --   function()
          --     vim.lsp.buf.format({ async = true })
          --   end,
          --   vim.tbl_extend("force", opts, { desc = "Format Code" })
          -- )
          vim.keymap.set(
            "n",
            "<leader>lf",
            function()
              vim.lsp.buf.format({ 
                async = true,
                filter = function(client)
                  return client.name == "null-ls"
                end
              })
            end,
            vim.tbl_extend("force", opts, { desc = "Format Code" })
          )
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })

      -----------------------------------------------------------------------
      -- Enable the servers (after configs are defined)
      -----------------------------------------------------------------------
      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "html",
        "vue_ls",
      })
    end,
  },
}

return M
