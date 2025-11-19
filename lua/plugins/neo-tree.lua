return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		-- Set up neo-tree
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = false,
					hide_gitignored = true,
				},
				window = {
					width = 30, -- Percentage of screen width, you can adjust this value
					position = "left",
				},
				follow_current_file = {
					enabled = true,
				},
				git_status = {
					symbols = {
						added     = "✚",
						modified  = "",
						deleted   = "✖",
						renamed   = "󰁕",
						untracked = "",
						ignored   = "",
						unstaged  = "󰄱",
						staged    = "",
						conflict  = "",
					}
				},
			},
		})

		-- Toggle Neo-tree with <leader>e
		vim.keymap.set("n", "<leader>e", function()
			-- Check if Neo-tree is currently visible
			local manager = require("neo-tree.sources.manager")
			local renderer = require("neo-tree.ui.renderer")
			local state = manager.get_state("filesystem")
			
			if renderer.window_exists(state) then
				-- Neo-tree is open, just close it
				vim.cmd("Neotree toggle left")
			else
				-- Neo-tree is closed, open it and show help
				vim.cmd("Neotree toggle left")
				vim.notify("🧭 Neo-tree: a=Add, r=Rename, d=Delete, y=Copy, x=Cut, p=Paste, q=Close, ?=Help", vim.log.levels.INFO, { title = "Neo-tree" })
			end
		end)
	end,
}
