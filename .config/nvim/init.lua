---@diagnostic disable: undefined-global
vim.pack.add({
  'https://github.com/tpope/vim-dispatch',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/stevearc/oil.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

-- OPTIONS =====================================================================
vim.g.mapleader = ' '
vim.g.markdown_folding = 1

vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'
vim.o.infercase = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.virtualedit = 'block'
vim.o.breakindent = true
vim.o.smartindent = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.winborder = 'single'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.tabclose = 'left'
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.list = true
vim.opt.listchars = {
  lead = ' ',
  multispace = '··',
  nbsp = '␣',
  tab = '» ',
  trail = '·',
}

vim.diagnostic.config({ virtual_text = { current_line = true, severity = { min = 1, max = 1 } } })

vim.lsp.enable({
  'clangd',
  'lua_ls',
  'rust_analyzer',
  'ty',
})

vim.cmd.colorscheme('custom')

-- KEYMAPS =====================================================================
local map = vim.keymap.set

map('n', '<leader>o', vim.diagnostic.open_float)
map('n', '<leader>d', vim.diagnostic.setqflist)

map('n', '<leader>e', '<cmd>Oil --float<cr>')

map('n', '<esc>', '<cmd>nohlsearch<cr>')

map('t', '<esc><esc>', '<c-\\><c-n>')

map('n', 'gq<cr>', 'mzgggqG`z')
map('n', 'gq?', '<cmd>set formatprg? formatexpr?<cr>')

map('x', '<', '<gv')
map('x', '>', '>gv')

map('n', '<c-left>', '<c-w>5<')
map('n', '<c-down>', '<c-w>-')
map('n', '<c-up>', '<c-w>+')
map('n', '<c-right>', '<c-w>5>')

map('c', '<c-a>', '<home>')
map('c', '<c-b>', '<left>')
map('c', '<c-f>', '<right>')
map('c', '<c-x><c-a>', '<c-a>')
map('c', '<c-x><c-f>', '<c-f>')

map('n', '<leader>q', function()
  local cur_tabnr = vim.fn.tabpagenr()
  for _, wininfo in ipairs(vim.fn.getwininfo()) do
    if wininfo.quickfix == 1 and wininfo.tabnr == cur_tabnr then return vim.cmd.cclose() end
  end
  vim.cmd.copen()
end, { desc = 'Toggle quickfix window' })

map('n', '<leader>m', function()
  vim.ui.input({
    prompt = 'makeprg: ',
    default = vim.bo.makeprg,
    completion = 'shellcmdline',
  }, function(input)
    if input then vim.bo.makeprg = vim.fn.expandcmd(input) end
  end)
end, { desc = 'Set makeprg' })

map('n', '<leader>/', '<cmd>Pick grep_live<cr>')
map('n', '<leader>a', '<cmd>Pick buffers<cr>')
map('n', '<leader>f', '<cmd>Pick files<cr>')
map('n', '<leader>n', '<cmd>Pick nvim<cr>')
map('n', '<leader>p', '<cmd>Pick help<cr>')
map('n', '<leader>r', '<cmd>Pick resume<cr>')

-- PLUGINS =====================================================================
require('oil').setup({
  columns = {
    'permissions',
    'mtime',
    'size',
    'icon',
  },
  keymaps = {
    ['`'] = false,
    ['='] = { 'actions.cd', mode = 'n' },
  },
})

require('mini.ai').setup()
require('mini.completion').setup()
require('mini.icons').setup()
require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.surround').setup()

local snippets = require('mini.snippets')
snippets.setup({
  snippets = {
    snippets.gen_loader.from_lang(),
  },
})

vim.ui.select = MiniPick.ui_select

MiniPick.registry.nvim = function() return MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath('config') } }) end

local wipeout_cur = function() vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, { force = true }) end
local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }
MiniPick.registry.buffers = function() return MiniPick.builtin.buffers(nil, { mappings = buffer_mappings }) end

-- stylua: ignore
local ensure_installed = {
  'comment','cpp', 'css', 'diff', 'go', 'html',
  'python', 'regex', 'rust', 'toml', 'yaml', 'zig',
}
local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
local to_install = vim.tbl_filter(isnt_installed, ensure_installed)
if #to_install > 0 then require('nvim-treesitter').install(to_install) end

-- Autocommands ================================================================
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', {}),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp', {}),
  callback = function(ev)
    map({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action)
    map('n', '<leader>li', vim.lsp.buf.implementation)
    map('n', '<leader>ln', vim.lsp.buf.rename)
    map('n', '<leader>lr', vim.lsp.buf.references)
    map('n', '<leader>ls', vim.lsp.buf.workspace_symbol)
    map('n', '<leader>lt', vim.lsp.buf.type_definition)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/inlayHint', ev.buf) then
      map(
        'n',
        '<leader>lh',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        { desc = 'Toggle LSP inlay hints' }
      )
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-autostart', {}),
  callback = function(ev)
    if pcall(vim.treesitter.get_parser, ev.buf) then vim.treesitter.start(ev.buf) end
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('treesitter-update', {}),
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then vim.cmd('TSUpdate') end
  end,
})
