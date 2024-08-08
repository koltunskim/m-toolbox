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
	{ "junegunn/fzf",      dir = "~/.fzf", build = "./install --all" },
	{
		"junegunn/fzf.vim",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Files<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>Buffers<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>Rg><CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>rg", "<cmd>RG><CR>", { noremap = true })
		end
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
			--			vim.api.nvim_command('FzfLua setup_fzfvim_cmds')
			--			vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Files<CR>", { noremap = true })
			--			vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>Buffers<CR>", { noremap = true })
			--			vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>RG><CR>", { noremap = true })
		end
	},
	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "go", "html", "lua", "rust", "vimdoc", "c", "python", },
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-m-h>", "<cmd>TmuxNavigateLeft<cr>" },
			{ "<c-m-j>", "<cmd>TmuxNavigateDown<cr>" },
			{ "<c-m-k>", "<cmd>TmuxNavigateUp<cr>" },
			{ "<c-m-l>", "<cmd>TmuxNavigateRight<cr>" },
		},
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			print("Configuring Kanagawa colorscheme")
			vim.cmd.colorscheme("kanagawa")
			vim.api.nvim_set_hl(0, 'Normal', { bg = nil })
		end
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			local mirage = false
			local colors = require("ayu.colors")
			colors.generate(mirage) -- Pass `true` to enable mirage

			require("ayu").setup({
				mirage = mirage,
				terminal = true,
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here or leave it empty to use the default settings
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("mason").setup {}
			require("mason-lspconfig").setup {
				ensure_installed = { "lua_ls", "pyright", "ruff_lsp", "rust_analyzer", "bashls" },
			}
			require("mason-lspconfig").setup_handlers {
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {
						on_attach = function(client, bufnr)
							client.server_capabilities.semanticTokensProvider = nil
							vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end)
						end,
					}
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				["rust_analyzer"] = function()
					-- require("rust-tools").setup {}
				end
			}
			vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>", { noremap = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = buffer,
				callback = function()
					vim.lsp.buf.format { async = false }
				end
			})
		end,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"mrcjkb/rustaceanvim",
				version = "^4", -- Recommended
				lazy = false, -- This plugin is already lazy
			},
		},
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("null-ls").setup()
			require("mason-null-ls").setup({
				ensure_installed = { "tflint" }
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			vim.opt.completeopt = { "menu", "menuone", "noinsert" }

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"voldikss/vim-floaterm",
		keys = {
			{ "<f10>" },
		},
	},
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>nt", "<cmd> :NvimTreeToggle<cr>" },
		},
		config = function()
			require("nvim-tree").setup({
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 25,
					side = "left",
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
				},
			})
		end,
	},
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
