vim.cmd('highlight clear')
local hl = vim.api.nvim_set_hl
hl(0, 'Identifier', { fg = 'NvimLightMagenta' })
hl(0, 'Function', { fg = 'NvimLightBlue' })
hl(0, 'DiffAdd', { bg = 'NvimDarkGreen', fg = 'none' })
hl(0, 'DiffChange', { bg = 'NvimDarkGray4', fg = 'none' })
hl(0, 'DiffText', { bg = 'NvimDarkCyan', fg = 'none' })
