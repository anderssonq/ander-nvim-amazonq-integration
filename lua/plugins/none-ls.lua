-- none-ls.nvim: Null Language Server for additional LSP features
-- Provides formatting and diagnostics for languages without native LSP support
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    
    null_ls.setup({
      sources = {
        -- JavaScript/TypeScript/Vue formatting using project's .prettierrc config
        null_ls.builtins.formatting.prettier.with({
          prefer_local = "node_modules/.bin", -- Use project's local prettier
        }),
        -- Lua code formatting
        null_ls.builtins.formatting.stylua,
      },
    })
  end,
}
