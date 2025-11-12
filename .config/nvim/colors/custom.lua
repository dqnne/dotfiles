local palette = require('mini.hues').make_palette({
  background = '#0a1114',
  foreground = '#dbd6ce',
})

palette.accent = '#dbd6ce'
palette.accent_bg = '#142228'

require('mini.hues').apply_palette(palette)
vim.g.colors_name = 'custom'
