return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"williamboman/mason-lspconfig.nvim",
			"folke/neoconf.nvim",
		},
		config = function(_, _)
			local lspconfig = require("lspconfig")
			local utils = require("utils")
			local mason = require("mason").setup({})
			local mason_lspconfig = require("mason-lspconfig")
			local lsp_utils = require("plugins.lsp.lsp-utils")
			local cmp = require("cmp")

			mason_lspconfig.setup({
				ensure_installed = utils.lsp_servers,
				handlers = {
					lsp_utils.default_setup,
					lua_ls = function()
						lspconfig.lua_ls.setup({
							--on_attach = lsp_utils.on_attach,
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									diagnostics = { globals = { "vim" } },
									workspace = {
										library = vim.env.VIMRUNTIME,
									},
								},
							},
						})
					end,
					clangd = function()
						lspconfig.clangd.setup({
							keys = {
								"<leader>cR",
								"<cmd>ClangdSwitchSourceHeader<cr>",
								desc = "Switch Source/Header (C/C++)",
							},
							root_dir = function(filename)
								return lspconfig.util.root_pattern(
									"Makefile",
									"configure.ac",
									"configure.in",
									"config.h.in",
									"meson.build",
									"meson_options.txt",
									"build.ninja"
								)(filename) or lspconfig.util.root_pattern(
									"compile_commands.json",
									"compile_flags.txt"
								)(filename) or lspconfig.util.find_git_ancestor(filename)
							end,
							capabilities = {
								offsetEncoding = { "utf-16" },
							},
							cmd = {
								"clangd",
								"--background-index",
								"--clang-tidy",
								"--header-insertion=iwyu",
								"--completion-style=detailed",
								"--function-arg-placeholders",
								"--fallback-style=llvm",
							},
							init_options = {
								usePlaceholders = true,
								completeUnimported = true,
								clangdFileStatus = true,
							},
						})
					end,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {
			pip = {
				upgrade_pip = true,
			},
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local utils = require("utils")
			local mr = require("mason-registry")
			local packages = utils.mason_packages
			local function ensure_installed()
				for _, package in ipairs(packages) do
					local p = mr.get_package(package)
					if not p:is_installed() then
						p:install()
					end
				end
			end

			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
