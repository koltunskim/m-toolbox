return {
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{
		"junegunn/fzf.vim",
		config = function()
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
	}
}
