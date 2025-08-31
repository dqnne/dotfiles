local wezterm = require('wezterm')

local act = wezterm.action
local config = wezterm.config_builder()

config.font = wezterm.font('Iosevka Term Extended')
config.font_size = 12

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.disable_default_key_bindings = true

config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  { key = 's', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = 't', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },

  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },

  { key = 'w', mods = 'LEADER', action = act.CloseCurrentPane({ confirm = true }) },
  { key = 'q', mods = 'LEADER', action = act.CloseCurrentTab({ confirm = true }) },

  { key = 'd', mods = 'LEADER', action = act.ShowDebugOverlay },
  { key = 'm', mods = 'LEADER', action = act.ShowLauncher },
  { key = 'p', mods = 'LEADER', action = act.ActivateCommandPalette },
  { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },

  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = '/', mods = 'LEADER', action = act.Search({ CaseSensitiveString = '' }) },

  { key = 'Space', mods = 'LEADER|CTRL', action = act.SendKey({ key = 'Space', mods = 'CTRL' }) },

  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize({ 'Left', 1 }) },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize({ 'Down', 1 }) },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize({ 'Up', 1 }) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize({ 'Right', 1 }) },

  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },

  { key = '_', mods = 'CTRL|SHIFT', action = act.DecreaseFontSize },
  { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
  { key = ')', mods = 'CTRL|SHIFT', action = act.ResetFontSize },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

config.colors = {
  foreground = '#ffffff',
  background = '#101010',

  cursor_bg = '#cee5e5',
  cursor_fg = '#101010',
  cursor_border = '#cee5e5',

  selection_fg = '#101010',
  selection_bg = '#b7cccc',

  scrollbar_thumb = '#282828',

  split = '#484848',

  ansi = {
    '#282828',
    '#b77979',
    '#79b779',
    '#b7b779',
    '#7979b7',
    '#b779b7',
    '#79b7b7',
    '#e0e0e0',
  },
  brights = {
    '#383838',
    '#b77979',
    '#79b779',
    '#b7b779',
    '#7979b7',
    '#b779b7',
    '#79b7b7',
    '#ffffff',
  },

  tab_bar = {
    background = '#101010',

    active_tab = {
      bg_color = '#282828',
      fg_color = '#ffffff',

      intensity = 'Bold',
    },

    inactive_tab = {
      bg_color = '#181818',
      fg_color = '#c8c8c8',
    },

    inactive_tab_hover = {
      bg_color = '#282828',
      fg_color = '#c8c8c8',
    },

    new_tab = {
      bg_color = '#181818',
      fg_color = '#c8c8c8',
    },

    new_tab_hover = {
      bg_color = '#282828',
      fg_color = '#c8c8c8',
    },
  },
}

return config
