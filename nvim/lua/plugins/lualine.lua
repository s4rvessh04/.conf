return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup {
			options = {
				theme = 'horizon',
				component_separators = '|',
				section_separators = '',
			},
		}
	end
}
