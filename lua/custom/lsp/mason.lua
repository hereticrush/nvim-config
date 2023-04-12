local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not lspconfig_status_ok then
	return
end

local null_ls_status_ok, null_ls = pcall(require, "mason-null-ls")
if not null_ls_status_ok then
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"cmake",
		"clangd",
		"html",
		"rust_analyzer",
		"lua_ls",
		"tsserver",
		"tailwindcss",
		"gopls",
		"pyright",
		"yamlls",
		"omnisharp",
	},
})

null_ls.setup({
	ensure_installed = {
		"prettier",
		"json-lsp",
		"shfmt",
		"stylua",
		"eslint_d",
		"clang_format",
		"flake8",
	},
})
