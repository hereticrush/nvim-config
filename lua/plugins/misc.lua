return {
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "folke/neodev.nvim", opts = {} },
	-- Utilities
	{
		"folke/persistence.nvim",
		lazy = false,
		keys = {
			{
				"<leader>ls",
				function()
					require("persistence").load()
				end,
			},
		},
		opts = { options = { "buffers", "curdir", "folds", "help", "tabpages", "terminal", "globals" } },
	},
}
