local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  opts = {
    char = "",
    context_char = "|",
    show_current_context = true,
    show_current_context_start = true,
    use_treesitter = true,
    context_patterns = { 'class', 'function', 'method' },
    filetype_exclude = { 'help', 'packer', 'nvimtree', 'dashboard' },
    buftype_exclude = { 'terminal', 'nofile', 'quickfix' },
  },
}

return M
