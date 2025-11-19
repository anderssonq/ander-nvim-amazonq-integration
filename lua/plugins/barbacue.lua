return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- you can keep this or remove it, config() is what matters now
  },
  config = function()
    require("barbecue").setup({
      -- 🔴 IMPORTANT: let us control nvim-navic manually
      attach_navic = false,

      -- your existing theme config:
      theme = {
        -- this highlight is used to override other highlights
        normal = { fg = "#c0caf5" },

        -- these highlights correspond to symbols table from config
        ellipsis = { fg = "#737aa2" },
        separator = { fg = "#737aa2" },
        modified = { fg = "#737aa2" },

        -- these highlights represent the _text_ of three main parts of barbecue
        dirname = { fg = "#737aa2" },
        basename = { bold = true },
        context = {},

        -- these highlights are used for context/navic icons
        context_file = { fg = "#ac8fe4" },
        context_module = { fg = "#ac8fe4" },
        context_namespace = { fg = "#ac8fe4" },
        context_package = { fg = "#ac8fe4" },
        context_class = { fg = "#ac8fe4" },
        context_method = { fg = "#ac8fe4" },
        context_property = { fg = "#ac8fe4" },
        context_field = { fg = "#ac8fe4" },
        context_constructor = { fg = "#ac8fe4" },
        context_enum = { fg = "#ac8fe4" },
        context_interface = { fg = "#ac8fe4" },
        context_function = { fg = "#ac8fe4" },
        context_variable = { fg = "#ac8fe4" },
        context_constant = { fg = "#ac8fe4" },
        context_string = { fg = "#ac8fe4" },
        context_number = { fg = "#ac8fe4" },
        context_boolean = { fg = "#ac8fe4" },
        context_array = { fg = "#ac8fe4" },
        context_object = { fg = "#ac8fe4" },
        context_key = { fg = "#ac8fe4" },
        context_null = { fg = "#ac8fe4" },
        context_enum_member = { fg = "#ac8fe4" },
        context_struct = { fg = "#ac8fe4" },
        context_event = { fg = "#ac8fe4" },
        context_operator = { fg = "#ac8fe4" },
        context_type_parameter = { fg = "#ac8fe4" },
      },
    })
  end,
}
