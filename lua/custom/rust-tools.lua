local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
	return
end

local keymap = vim.keymap

rust_tools.setup({
	tools = {
		inlay_hints = {
			auto = true,
		},
		executor = require("rust-tools.executors").termopen,
		reload_workspace_from_cargo_toml = true,
	},
	server = {
		on_attach = function(_, bufnr)
			keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
			keymap.set("n", "<leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})
