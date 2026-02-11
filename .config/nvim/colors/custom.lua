local palette = require('mini.hues').make_palette({
  background = '#101214',
  foreground = '#e5ddce',
})

palette.accent = '#e5ddce'
palette.accent_bg = '#202428'

require('mini.hues').apply_palette(palette)
vim.g.colors_name = 'custom'
