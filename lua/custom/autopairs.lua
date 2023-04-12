local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

autopairs.setup({check_ts = true})
local cmp_status_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if not cmp_status_ok then
  return
end

local s, cmp = pcall(require, 'cmp')
if not s then
 return
end
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

