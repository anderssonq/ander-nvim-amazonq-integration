return {
	"zakissimo/smoji.nvim",
	config = function()
		require("smoji")
		vim.keymap.set("n", "<Leader><Leader>e", "<CMD>Smoji<CR>")
	end,
}
