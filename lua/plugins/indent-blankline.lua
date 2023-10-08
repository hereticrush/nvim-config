local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
<<<<<<< HEAD
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
=======
  opts = {
    indent = {
      highlight = { "CursorColumn", "Whitespace" },
      char = "|",
      tab_char = ".",
    },
    whitespace = {
      highlight = { "Function", "Label" },
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      include = {
        node_type = {
          c = { "return_statement" },
          lua = { "return_statement", "table_constructor" },
        },
      },
    },
    debounce = 100,
    exclude = {
      buftypes = { 'terminal', 'nofile', 'quickfix', 'prompt' },
    },
  },
>>>>>>> c70e53e (update: options ibl version 3)
}

return M
