local opt = vim.opt

vim.cmd("filetype plugin indent on")
opt.shortmess = vim.o.shortmess .. "c"
opt.hidden = true
opt.whichwrap = "b,s,<,>,[,],h,l"
opt.pumheight = 10
opt.fileencoding = "utf-8"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.clipboard:append("unnamedplus")
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.tabstop = 2
opt.shiftwidth = 2
opt.background = "dark"
opt.autoindent = true
opt.expandtab = true
opt.backspace = "indent,eol,start"
opt.iskeyword:append("-")

local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

---Highlight yanked text
au("TextYankPost", {
	group = ag("yank_highlight", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 })
	end,
})
