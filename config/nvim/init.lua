--vim.opt.background = "dark"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.encoding = "UTF-8"
vim.opt.expandtab = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 7
vim.opt.shiftwidth = 4
vim.opt.startofline = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.api.nvim_set_keymap("n", "<leader>c", ":", { noremap = true })


------
--LAZY
------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options
vim.g.mapleader = ","       -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

vim.g.floaterm_keymap_toggle = "0"


require("lazy").setup({
	{ import = 'm.plugins' }
})
-----------
--FUNCTIONS
-----------
function ToggleSetNumber()
	if vim.wo.number then
		vim.wo.number = false
		vim.wo.relativenumber = false
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
	end
end

vim.api.nvim_create_user_command('ToggleSetNumber', ToggleSetNumber, {})
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>ToggleSetNumber<CR>', { noremap = true, silent = true })

vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
	if vim.g.diagnostics_active then
		vim.g.diagnostics_active = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_active = true
		vim.diagnostic.enable()
	end
end

vim.keymap.set('n', '<leader>xd', Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })
