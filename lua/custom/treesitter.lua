local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
treesitter.setup({
	ensure_installed = {
		"lua",
		"vim",
		"cpp",
		"rust",
		"c",
		"javascript",
		"python",
		"go",
		"bash",
		"json",
		"typescript",
		"gitignore",
		"yaml",
		"cmake",
		"comment",
		"cpp",
		"dockerfile",
	},
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	sync_install = true,
	indent = { enable = false },
	autotag = { enable = true },
	autopairs = {
		enable = true,
	},
})
