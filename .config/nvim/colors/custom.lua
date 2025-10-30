local p = {
  fg = '#edefea',
  fg2 = '#dbd9d0',
  fg3 = '#cec6b9',
  fg4 = '#b8baa7',
  fg5 = '#9ca29c',
  fg6 = '#838a8b',

  bg = '#090f12',
  bg2 = '#182126',
  bg3 = '#273136',
  bg4 = '#3c4b4f',
  bg5 = '#5b605a',
  bg6 = '#626e70',

  light_red = '#b77979',
  light_green = '#79b779',
  light_yellow = '#b7b779',
  light_blue = '#7979b7',
  light_magenta = '#b779b7',
  light_cyan = '#79b7b7',

  dark_red = '#2d1e1e',
  dark_green = '#1e2d1e',
  dark_yellow = '#2d2d1e',
  dark_blue = '#1e1e2d',
  dark_magenta = '#2d1e2d',
  dark_cyan = '#1e2d2d',
}

local function hi(group, data) vim.api.nvim_set_hl(0, group, data) end

-- stylua: ignore
local function enable_colorscheme()
  vim.cmd('hi clear')
  vim.g.colors_name = 'custom'

  hi('Added',                    { fg = p.light_green })
  hi('Boolean',                  { fg = p.fg3 })
  hi('Changed',                  { fg = p.light_cyan })
  hi('Character',                { fg = p.fg4, italic = true })
  hi('Comment',                  { fg = p.bg5, italic = true })
  hi('Constant',                 { fg = p.fg5 })
  hi('Delimiter',                { fg = p.bg6 })
  hi('Error',                    { fg = p.light_red })
  hi('Float',                    { fg = p.fg4 })
  hi('Function',                 { fg = p.fg5 })
  hi('Identifier',               { fg = p.fg6 })
  hi('Keyword',                  { fg = p.fg3 })
  hi('Number',                   { fg = p.fg4 })
  hi('Operator',                 { fg = p.bg6 })
  hi('PreProc',                  { fg = p.fg4 })
  hi('Removed',                  { fg = p.light_red })
  hi('Special',                  { fg = p.fg3 })
  hi('Statement',                { fg = p.fg3 })
  hi('String',                   { fg = p.fg4 })
  hi('Type',                     { fg = p.fg5 })

  hi('ColorColumn',              { bg = p.bg3 })
  hi('Conceal',                  { fg = p.fg6, bold = true, italic = true })
  hi('CurSearch',                { fg = p.bg, bg = p.fg, bold = true })
  hi('Cursor',                   { fg = p.bg, bg = p.fg2 })
  hi('CursorColumn',             { bg = p.bg2 })
  hi('CursorLine',               { bg = p.bg2 })
  hi('CursorLineNr',             { fg = p.fg2, bg = p.bg2, bold = true })
  hi('CursorLineSign',           { bg = p.bg2 })
  hi('DiffAdd',                  { bg = p.dark_green })
  hi('DiffChange',               { bg = p.dark_cyan })
  hi('DiffDelete',               { bg = p.dark_red })
  hi('DiffText',                 { bg = p.dark_yellow })
  hi('Directory',                { fg = p.fg5 })
  hi('EndOfBuffer',              { fg = p.bg6 })
  hi('ErrorMsg',                 { fg = p.light_red })
  hi('FloatBorder',              { fg = p.bg5 })
  hi('FloatTitle',               { fg = p.fg4, bg = p.bg4, bold = true })
  hi('FoldColumn',               { fg = p.fg6 })
  hi('Folded',                   { fg = p.fg3 })
  hi('IncSearch',                { fg = p.bg, bg = p.fg, bold = true })
  hi('LineNr',                   { fg = p.bg4 })
  hi('LspInlayHint',             { fg = p.fg6, bg = p.bg3 })
  hi('LspReferenceText',         { bg = p.bg3 })
  hi('MatchParen',               { fg = p.fg, bg = p.bg5 })
  hi('ModeMsg',                  { fg = p.fg2, bold = true })
  hi('MoreMsg',                  { fg = p.light_green, bold = true })
  hi('NonText',                  { fg = p.bg4 })
  hi('Normal',                   { fg = p.fg2, bg = p.bg })
  hi('NormalFloat',              { bg = p.bg })
  hi('Pmenu',                    { bg = p.bg3 })
  hi('PmenuSbar',                { bg = p.bg4 })
  hi('PmenuSel',                 { bg = p.bg5 })
  hi('PmenuThumb',               { bg = p.bg6 })
  hi('Question',                 { fg = p.light_green, bold = true })
  hi('QuickFixLine',             { fg = p.fg4 })
  hi('Search',                   { fg = p.fg, bg = p.bg6 })
  hi('SignColumn',               { fg = p.fg6 })
  hi('SpecialKey',               { fg = p.bg6, italic = true })
  hi('SpellBad',                 { fg = p.light_red, undercurl = true })
  hi('SpellCap',                 { fg = p.light_red, undercurl = true })
  hi('SpellLocal',               { fg = p.light_red, undercurl = true })
  hi('SpellRare',                { fg = p.light_red, undercurl = true })
  hi('StatusLine',               { fg = p.fg5, bg = p.bg3 })
  hi('StatusLineNC',             { fg = p.fg6, bg = p.bg3 })
  hi('Substitute',               { fg = p.fg, bg = p.fg6 })
  hi('TabLine',                  { fg = p.fg3, bg = p.bg4 })
  hi('TabLineFill',              { fg = p.fg2, bg = p.bg3 })
  hi('TabLineSel',               { bold = true })
  hi('TermCursor',               { fg = p.bg3, bg = p.fg })
  hi('Title',                    { fg = p.fg4, bold = true })
  hi('Visual',                   { bg = p.bg4 })
  hi('WarningMsg',               { fg = p.light_yellow })
  hi('Whitespace',               { fg = p.bg3 })
  hi('WildMenu',                 { fg = p.bg, bg = p.bg6 })
  hi('WinBar',                   { fg = p.fg4, bg = p.bg4 })
  hi('WinBarNC',                 { fg = p.fg2, bg = p.bg3 })
  hi('WinSeparator',             { fg = p.bg5, bg = p.bg3 })
  hi('lCursor',                  { fg = p.bg3, bg = p.fg3 })

  hi('DiagnosticError',          { fg = p.light_red })
  hi('DiagnosticHint',           { fg = p.light_magenta })
  hi('DiagnosticInfo',           { fg = p.light_cyan })
  hi('DiagnosticOk',             { fg = p.light_green })
  hi('DiagnosticWarn',           { fg = p.light_yellow })
  hi('DiagnosticUnderlineError', { undercurl = true, sp = p.light_red })
  hi('DiagnosticUnderlineHint',  { undercurl = true, sp = p.light_magenta })
  hi('DiagnosticUnderlineInfo',  { undercurl = true, sp = p.light_cyan })
  hi('DiagnosticUnderlineOk',    { undercurl = true, sp = p.light_green })
  hi('DiagnosticUnderlineWarn',  { undercurl = true, sp = p.light_yellow })

  hi('@text.literal',            { link='Comment' })
  hi('@text.reference',          { link='Identifier' })
  hi('@text.title',              { link='Title' })
  hi('@text.uri',                { link='Underlined' })
  hi('@text.underline',          { link='Underlined' })
  hi('@text.todo',               { link='Todo' })

  hi('@comment',                 { link='Comment' })
  hi('@punctuation',             { link='Delimiter' })

  hi('@constant',                { link='Constant' })
  hi('@constant.builtin',        { link='Special' })
  hi('@constant.macro',          { link='Define' })
  hi('@define',                  { link='Define' })
  hi('@macro',                   { link='Macro' })
  hi('@string',                  { link='String' })
  hi('@string.escape',           { link='SpecialChar' })
  hi('@string.special',          { link='SpecialChar' })
  hi('@character',               { link='Character' })
  hi('@character.special',       { link='SpecialChar' })
  hi('@number',                  { link='Number' })
  hi('@boolean',                 { link='Boolean' })
  hi('@float',                   { link='Float' })

  hi('@function',                { link='Function' })
  hi('@function.builtin',        { link='Special' })
  hi('@function.macro',          { link='Macro' })
  hi('@parameter',               { link='Identifier' })
  hi('@method',                  { link='Function' })
  hi('@field',                   { link='Identifier' })
  hi('@property',                { link='Identifier' })
  hi('@constructor',             { link='Special' })

  hi('@conditional',             { link='Conditional' })
  hi('@repeat',                  { link='Repeat' })
  hi('@label',                   { link='Label' })
  hi('@operator',                { link='Operator' })
  hi('@keyword',                 { link='Keyword' })
  hi('@exception',               { link='Exception' })

  hi('@variable',                { fg=nil, bg=nil })
  hi('@type',                    { link='Type' })
  hi('@type.definition',         { link='Typedef' })
  hi('@storageclass',            { link='StorageClass' })
  hi('@namespace',               { link='Identifier' })
  hi('@include',                 { link='Include' })
  hi('@preproc',                 { link='PreProc' })
  hi('@debug',                   { link='Debug' })
  hi('@tag',                     { link='Tag' })

  hi('@lsp.type.class',          { link='Structure' })
  hi('@lsp.type.comment',        { link='Comment' })
  hi('@lsp.type.decorator',      { link='Function' })
  hi('@lsp.type.enum',           { link='Structure' })
  hi('@lsp.type.enumMember',     { link='Constant' })
  hi('@lsp.type.function',       { link='Function' })
  hi('@lsp.type.interface',      { link='Structure' })
  hi('@lsp.type.macro',          { link='Macro' })
  hi('@lsp.type.method',         { link='Function' })
  hi('@lsp.type.namespace',      { link='Structure' })
  hi('@lsp.type.parameter',      { link='Identifier' })
  hi('@lsp.type.property',       { link='Identifier' })
  hi('@lsp.type.struct',         { link='Structure' })
  hi('@lsp.type.type',           { link='Type' })
  hi('@lsp.type.typeParameter',  { link='TypeDef' })
  hi('@lsp.type.variable',       { link='@variable' })

  vim.g.terminal_color_0 = p.bg3
  vim.g.terminal_color_1 = p.light_red
  vim.g.terminal_color_2 = p.light_green
  vim.g.terminal_color_3 = p.light_yellow
  vim.g.terminal_color_4 = p.light_blue
  vim.g.terminal_color_5 = p.light_magenta
  vim.g.terminal_color_6 = p.light_cyan
  vim.g.terminal_color_7 = p.fg2

  vim.g.terminal_color_8 = p.bg4
  vim.g.terminal_color_9 = p.light_red
  vim.g.terminal_color_10 = p.light_green
  vim.g.terminal_color_11 = p.light_yellow
  vim.g.terminal_color_12 = p.light_blue
  vim.g.terminal_color_13 = p.light_magenta
  vim.g.terminal_color_14 = p.light_cyan
  vim.g.terminal_color_15 = p.fg
end

enable_colorscheme()
