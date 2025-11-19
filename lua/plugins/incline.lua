return {
	"b0o/incline.nvim",
	event = "VeryLazy", -- Asegúrate de que este evento esté correctamente configurado para cuando quieras cargar el plugin.
	config = function()
		-- Importación de dependencias necesarias
		local helpers = require("incline.helpers")
		local devicons = require("nvim-web-devicons")

		-- Configuración de Incline
		require("incline").setup({
			window = {
				padding = { left = 0, right = 0 },
				margin = {
					horizontal = 0,
					vertical = {
						top = 0, -- Asegura que esté pegado al borde superior
						bottom = 1, -- Un pequeño margen inferior para evitar conflictos
					},
				},
				placement = { vertical = "top", horizontal = "right" }, -- Posiciona la barra en la parte superior derecha
			},
			render = function(props)
				-- Obtener el nombre del archivo
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end

				-- Obtener ícono y color
				local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
				local modified = vim.bo[props.buf].modified

				-- Verificar si es el buffer actual
				local is_current_buffer = vim.api.nvim_get_current_buf() == props.buf
				local bg_color = is_current_buffer and "#9bafe7" or "#44406e" -- Color distinto si es el buffer actual
        local fg_color = is_current_buffer and "#000000" or "#ffffff" -- Cambiar color de letra a negro si es el buffer actual
				-- Verificar si es el buffer actual y agregar el símbolo de foco
				if vim.api.nvim_get_current_buf() == props.buf then
					filename = "⚲ " .. filename -- Añadir emoji de foco al archivo actual
				end
				-- Renderizar la línea de inclinación
				return {
					ft_icon and {
						" ",
						ft_icon,
						" ",
						guibg = ft_color,
						guifg = require("incline.helpers").contrast_color(ft_color),
					} or "",
					" ",
					{ filename, gui = modified and "bold,italic" or "bold", guifg = fg_color }, -- Aplicar el color de texto
					" ",
					guibg = bg_color, -- Color de fondo ajustado según si es el buffer actual
				}
			end,
		})
	end,
}
