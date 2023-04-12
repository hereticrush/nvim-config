local colorscheme = "nordfox"
local cmd = vim.cmd

local status_ok, _ = pcall(cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
