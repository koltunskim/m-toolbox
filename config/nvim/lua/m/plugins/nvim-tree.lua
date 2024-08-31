return {
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
}
