return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "meuter/lualine-so-fancy.nvim" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula",
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 100,
        },
      },
      sections = {
        lualine_z = {
          -- { "fancy_lsp_servers" },
          {
            function()
              return "🎸 www.andersoftware.com"
            end,
          },
        },
      },
    })
  end,
}
