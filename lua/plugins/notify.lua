local M = {
	"rcarriga/nvim-notify",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		timeout = 1500,
		fps = 60,
		render = "simple",
		stages = "fade_in_slide_out",
		background_colour = "#2e3440",
	},
}

return M
