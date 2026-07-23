vim.cmd('highlight clear')
local hl = vim.api.nvim_set_hl
hl(0, 'Identifier', { fg = 'NvimLightMagenta' })
hl(0, 'Function', { fg = 'NvimLightBlue' })
