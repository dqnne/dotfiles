vim.g.mapleader = ' '
vim.g.markdown_folding = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'
vim.o.expandtab = true
vim.o.exrc = true
vim.o.ignorecase = true
vim.o.infercase = true
vim.o.pumheight = 10
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = -1
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.updatetime = 1000
vim.o.virtualedit = 'block'
vim.o.wildcharm = ('\t'):byte()
vim.opt.complete:remove('t')
vim.opt.sessionoptions:append('localoptions')
vim.opt.shortmess:append('c')
vim.opt.wildoptions:append('fuzzy')

vim.o.cursorline = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'indent'
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.pumblend = 10
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabclose = 'uselast'
vim.o.winblend = 10
vim.o.winborder = 'rounded'
vim.o.wrap = false
vim.opt.fillchars:append('diff:╱')
vim.opt.listchars = {
  lead = ' ',
  multispace = '··',
  nbsp = '␣',
  tab = '» ',
  trail = '·',
  extends = '>',
  precedes = '<',
}

vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    severity = { min = vim.diagnostic.severity.ERROR, max = vim.diagnostic.severity.ERROR },
  },
})

vim.lsp.enable({
  'basedpyright',
  'clangd',
  'hls',
  'lua_ls',
  'rust_analyzer',
  'tinymist',
})
