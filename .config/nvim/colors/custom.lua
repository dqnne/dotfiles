local palette = require('mini.hues').make_palette({
  background = '#171319',
  foreground = '#d7d5cd',
  saturation = 'lowmedium',
  accent = 'fg',
})

palette.accent_bg = '#2f2733'

require('mini.hues').apply_palette(palette)
vim.g.colors_name = 'custom'
