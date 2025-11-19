return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require("leap")

    -- REEMPLAZA ESTO (obsoleto):
    -- leap.add_default_mappings()

    --------------------------------------------------------------------
    -- ⭐ Mapeos modernos recomendados por leap.nvim
    --------------------------------------------------------------------

    -- Normal & Visual mode: "s" para saltar hacia delante
    vim.keymap.set({ "n", "x", "o" }, "s", function()
      leap.leap({ forward = true })
    end)

    -- "S" para saltar hacia atrás
    vim.keymap.set({ "n", "x", "o" }, "S", function()
      leap.leap({ backward = true })
    end)

    -- El salto cruzando ventanas (igual que los defaults antiguos)
    vim.keymap.set({ "n", "x", "o" }, "gs", function()
      leap.leap({ target_windows = require("leap.util").get_enterable_windows() })
    end)

    --------------------------------------------------------------------
    -- Opciones
    --------------------------------------------------------------------
    leap.opts.case_sensitive = true
  end,
}
