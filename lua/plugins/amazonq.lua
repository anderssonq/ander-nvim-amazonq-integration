return {
  {
    name = "amazonq",
    url = "https://github.com/awslabs/amazonq.nvim.git",

    -- Load only when needed
    ft = {
      -- Frontend
      "javascript", "javascriptreact",
      "typescript", "typescriptreact",
      "vue", "vue.html",
      "json",

      -- Backend / DevOps
      "dockerfile", "yaml", "yml",
      "graphql", "gql",
      "markdown", "md",
      "bash", "sh",

      -- General-purpose
      "lua", "python", "go", "rust",
      "c", "cpp",

      -- Amazon Q Chat
      "amazonq",
    },

    config = function()
      require("amazonq").setup({

        -------------------------------------------------------------------
        -- REQUIRED: SSO URL
        -------------------------------------------------------------------
        ssoStartUrl = vim.fn.getenv('AMAZONQ_SSO_URL'),

        -------------------------------------------------------------------
        -- FIX PARA VOLTA → Forzar Node 18+ en AmazonQ
        -- Neovim usará Node 20 incluso si tu repo usa Node 14
        -------------------------------------------------------------------
        cmd_env = {
          VOLTA_HOME = "",
          VOLTA_BIN_DIR = "",
          PATH = "/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:" .. vim.fn.getenv("PATH"),
        },

        -------------------------------------------------------------------
        -- Inline Suggestions
        -------------------------------------------------------------------
        inline_suggest = true,
        -------------------------------------------------------------------
        -- Filetypes Amazon Q should assist with
        -------------------------------------------------------------------
        filetypes = {
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "vue", "vue.html",
          "json",

          "dockerfile",
          "yaml", "yml",
          "graphql", "gql",
          "markdown", "md",
          "bash", "sh",

          "lua", "python", "go", "rust",
          "c", "cpp",

          "amazonq",
        },

        -------------------------------------------------------------------
        -- Chat Window UI (opens like a VSCode sidebar)
        -------------------------------------------------------------------
        on_chat_open = function()
          -- safely try to close neo-tree (no error if not installed)
          pcall(vim.cmd, "Neotree close")

          vim.cmd([[
            vertical topleft 27vsplit
            setlocal wrap breakindent nonumber norelativenumber nolist
          ]])
        end,

        debug = false,
      })

      ---------------------------------------------------------------------
      -- Keymap: Open Amazon Q Chat
      ---------------------------------------------------------------------
      vim.keymap.set("n", "<leader>qc", "<cmd>Amazon<CR>", {
        desc = "Open Amazon Q Chat",
        noremap = true,
        silent = true,
      })

      vim.keymap.set("v", "<leader>qe", "<cmd>Amazon explain<CR>", { desc = "Explain code", silent = true })
      vim.keymap.set("v", "<leader>qf", "<cmd>Amazon fix<CR>", { desc = "Fix code", silent = true })
      vim.keymap.set("v", "<leader>qr", "<cmd>Amazon refactor<CR>", { desc = "Refactor code", silent = true })
    end,
  },
}
