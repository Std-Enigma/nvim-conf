local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
	vim.fn.getchar()
	vim.cmd.quit()
end

require("lazy").setup({
	{
		"AstroNvim/AstroNvim",
		version = "^5", -- Remove version tracking to elect for nightly AstroNvim
		import = "astronvim.plugins",
		opts = {
			mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
			maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
			icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
			pin_plugins = false, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
			update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
		},
	},
	{ import = "plugins.astro" },
	{ import = "plugins" },
} --[[@as LazySpec]], {
	install = { colorscheme = { "astrotheme", "habamax" } },
	ui = { backdrop = 100 },
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				-- "tohtml",
				"zipPlugin",
			},
		},
	},
} --[[@as LazyConfig]])
