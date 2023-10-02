local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
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
}

return M
