return {
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
	}
}
