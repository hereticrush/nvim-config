local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
  opts = {},
  indent = { highlight = { "CursorColumn", "Whitespace" }, char = "" },
  whitespace = {
        highlight = { "CursorColumn", "Whitespace" },
        remove_blankline_trail = false,
    },
  scope = { enabled = false },
  exclude = {
		buftypes = { "terminal" },
		filetypes = {
			"help",
			"dashboard",
			"dashpreview",
			"NvimTree",
			"neo-tree",
			"vista",
			"sagahover",
			"sagasignature",
			"packer",
			"lazy",
			"log",
			"lspsagafinder",
			"lspinfo",
			"dapui_scopes",
			"dapui_breakpoints",
			"dapui_stacks",
			"dapui_watches",
			"dap-repl",
			"toggleterm",
			"alpha",
			"coc-explorer",
		},
	}
}

return M
