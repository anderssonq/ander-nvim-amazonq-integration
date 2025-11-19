-------------------------------------------------------------------
-- 1) 🚫 Disable Volta inside Neovim BEFORE anything else loads
-------------------------------------------------------------------
vim.env.VOLTA_HOME = nil
vim.env.VOLTA_BIN_DIR = nil

-- Remove Volta paths from PATH completely
vim.env.PATH = vim.env.PATH
  :gsub("/Users/aquintero/.volta/bin:", "")
  :gsub(":/Users/aquintero/.volta/bin", "")

-- Prepend Homebrew Node (this is your real Node)
vim.env.PATH = "/opt/homebrew/opt/node/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:" .. vim.env.PATH

-------------------------------------------------------------------
-- 2) Bootstrap lazy.nvim
-------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------
-- 3) Load vim-config AFTER cleaning PATH
-------------------------------------------------------------------
require("vim-config")

-------------------------------------------------------------------
-- 4) Load plugins
-------------------------------------------------------------------
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})
