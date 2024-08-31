return {
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
	}
}
