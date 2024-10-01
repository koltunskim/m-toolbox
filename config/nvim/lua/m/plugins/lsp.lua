return { {
	"neovim/nvim-lspconfig",
	config = function()
		require("mason").setup {}
		require("mason-lspconfig").setup {
			ensure_installed = { "lua_ls", "pyright", "ruff_lsp", "rust_analyzer", "bashls", "terraformls" },
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
}
