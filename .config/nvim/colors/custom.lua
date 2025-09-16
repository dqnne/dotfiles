-- Color palette
local p = {
  color_0 = '#cee5e5',
  color_1 = '#b7cccc',
  color_2 = '#a0b2b2',
  color_3 = '#889999',
  color_4 = '#727f7f',
  color_5 = '#5b6666',

  gray_0 = '#ffffff',
  gray_1 = '#e8e8e8',
  gray_2 = '#c8c8c8',
  gray_3 = '#a8a8a8',
  gray_4 = '#888888',
  gray_5 = '#787878',
  gray_6 = '#585858',
  gray_7 = '#484848',
  gray_8 = '#383838',
  gray_9 = '#282828',
  gray_10 = '#181818',
  gray_11 = '#101010',

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
  hi('Boolean',                  { fg = p.gray_2 })
  hi('Changed',                  { fg = p.light_cyan })
  hi('Character',                { fg = p.color_2, italic = true })
  hi('Comment',                  { fg = p.color_5, italic = true })
  hi('Constant',                 { fg = p.color_2 })
  hi('Delimiter',                { fg = p.color_4 })
  hi('Error',                    { fg = p.light_red })
  hi('Float',                    { fg = p.color_2 })
  hi('Function',                 { fg = p.color_3 })
  hi('Identifier',               { fg = p.gray_5 })
  hi('Keyword',                  { fg = p.color_1 })
  hi('Number',                   { fg = p.color_2 })
  hi('Operator',                 { fg = p.color_4 })
  hi('PreProc',                  { fg = p.gray_3 })
  hi('Removed',                  { fg = p.light_red })
  hi('Special',                  { fg = p.gray_2 })
  hi('SpecialComment',           { fg = p.color_5 })
  hi('Statement',                { fg = p.color_0, bold = true })
  hi('String',                   { fg = p.color_2 })
  hi('Type',                     { fg = p.gray_4 })

  hi('ColorColumn',              { bg = p.gray_9 })
  hi('Conceal',                  { fg = p.color_5, bold = true, italic = true })
  hi('CurSearch',                { fg = p.gray_11, bg = p.gray_0, bold = true })
  hi('Cursor',                   { fg = p.gray_11, bg = p.color_0 })
  hi('CursorColumn',             { bg = p.gray_9 })
  hi('CursorLine',               { bg = p.gray_9 })
  hi('CursorLineNr',             { fg = p.color_0, bg = p.gray_9, bold = true })
  hi('CursorLineSign',           { bg = p.gray_9 })
  hi('DiffAdd',                  { bg = p.dark_green })
  hi('DiffChange',               { bg = p.dark_cyan })
  hi('DiffDelete',               { bg = p.dark_red })
  hi('DiffText',                 { bg = p.dark_yellow })
  hi('Directory',                { fg = p.color_3, bold = true })
  hi('EndOfBuffer',              { fg = p.gray_6 })
  hi('ErrorMsg',                 { fg = p.light_red })
  hi('FloatBorder',              { fg = p.color_5 })
  hi('FloatTitle',               { fg = p.gray_3, bg = p.gray_8, bold = true })
  hi('FoldColumn',               { fg = p.color_5 })
  hi('Folded',                   { fg = p.gray_2 })
  hi('IncSearch',                { fg = p.gray_11, bg = p.gray_0, bold = true })
  hi('LineNr',                   { fg = p.color_5 })
  hi('LspInlayHint',             { fg = p.gray_5, bg = p.gray_9 })
  hi('LspReferenceText',         { bg = p.gray_9 })
  hi('MatchParen',               { fg = p.gray_0, bg = p.gray_6 })
  hi('ModeMsg',                  { fg = p.gray_0, bg = p.gray_11, bold = true })
  hi('MoreMsg',                  { fg = p.light_green, bold = true })
  hi('NonText',                  { fg = p.gray_9 })
  hi('Normal',                   { fg = p.gray_1, bg = p.gray_11 })
  hi('NormalFloat',              { bg = p.gray_10 })
  hi('Pmenu',                    { bg = p.gray_8 })
  hi('PmenuSbar',                { bg = p.gray_6 })
  hi('PmenuSel',                 { bg = p.gray_7 })
  hi('PmenuThumb',               { bg = p.gray_5 })
  hi('Question',                 { fg = p.light_green, bold = true })
  hi('QuickFixLine',             { fg = p.color_0 })
  hi('Search',                   { fg = p.gray_0, bg = p.gray_6 })
  hi('SignColumn',               { fg = p.color_5 })
  hi('SpecialKey',               { fg = p.gray_6, italic = true })
  hi('SpellBad',                 { fg = p.light_red, undercurl = true })
  hi('SpellCap',                 { fg = p.light_red, undercurl = true })
  hi('SpellLocal',               { fg = p.light_red, undercurl = true })
  hi('SpellRare',                { fg = p.light_red, undercurl = true })
  hi('StatusLine',               { fg = p.gray_0, bg = p.gray_9 })
  hi('StatusLineNC',             { fg = p.gray_3, bg = p.gray_9 })
  hi('Substitute',               { fg = p.gray_0, bg = p.color_5 })
  hi('TabLine',                  { fg = p.gray_2, bg = p.gray_8 })
  hi('TabLineFill',              { fg = p.gray_1, bg = p.gray_9 })
  hi('TabLineSel',               { bold = true })
  hi('TermCursor',               { fg = p.gray_9, bg = p.gray_0 })
  hi('Title',                    { fg = p.gray_3, bold = true })
  hi('Visual',                   { fg = p.gray_11, bg = p.color_2 })
  hi('WarningMsg',               { fg = p.light_yellow })
  hi('Whitespace',               { fg = p.gray_9 })
  hi('WildMenu',                 { fg = p.gray_11, bg = p.gray_6 })
  hi('WinBar',                   { fg = p.gray_3, bg = p.gray_8 })
  hi('WinBarNC',                 { fg = p.gray_1, bg = p.gray_9 })
  hi('WinSeparator',             { fg = p.gray_7, bg = p.gray_9 })
  hi('lCursor',                  { fg = p.gray_9, bg = p.gray_2 })

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

  -- Treesitter ----------------------------------------------------------------
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

  vim.g.terminal_color_0 = p.gray_9
  vim.g.terminal_color_1 = p.light_red
  vim.g.terminal_color_2 = p.light_green
  vim.g.terminal_color_3 = p.light_yellow
  vim.g.terminal_color_4 = p.light_blue
  vim.g.terminal_color_5 = p.light_magenta
  vim.g.terminal_color_6 = p.light_cyan
  vim.g.terminal_color_7 = p.gray_1

  vim.g.terminal_color_8 = p.gray_8
  vim.g.terminal_color_9 = p.light_red
  vim.g.terminal_color_10 = p.light_green
  vim.g.terminal_color_11 = p.light_yellow
  vim.g.terminal_color_12 = p.light_blue
  vim.g.terminal_color_13 = p.light_magenta
  vim.g.terminal_color_14 = p.light_cyan
  vim.g.terminal_color_15 = p.gray_0
end

enable_colorscheme()
