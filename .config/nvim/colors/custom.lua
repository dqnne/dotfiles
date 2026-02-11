local palette = require('mini.hues').make_palette({
  background = '#0e1214',
  foreground = '#d8d4cd',
})

palette.accent = '#d8d4cd'
palette.accent_bg = '#1c2428'

require('mini.hues').apply_palette(palette)
vim.g.colors_name = 'custom'
