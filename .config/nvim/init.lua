---@diagnostic disable: undefined-global

vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/tpope/vim-dispatch',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-sleuth',
})

vim.cmd.packadd('nvim.undotree')

require('vim._extui').enable({})

-- OPTIONS =====================================================================

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
vim.o.sessionoptions = vim.o.sessionoptions .. ',localoptions'
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = -1
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.virtualedit = 'block'
vim.o.wildoptions = 'pum,tagfile,fuzzy'

vim.o.cursorline = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'indent'
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabclose = 'left'
vim.o.winborder = 'rounded'
vim.opt.listchars = {
  lead = ' ',
  multispace = '··',
  nbsp = '␣',
  tab = '» ',
  trail = '·',
  extends = '>',
  precedes = '<',
}

vim.diagnostic.config({ virtual_text = { current_line = true, severity = { min = 1, max = 1 } } })

vim.lsp.enable({
  'basedpyright',
  'clangd',
  'hls',
  'lua_ls',
  'rust_analyzer',
  'tinymist',
})

vim.cmd.colorscheme('custom')

-- KEYMAPS =====================================================================

local map = vim.keymap.set

map('n', '<leader>d', vim.diagnostic.setqflist)

map('n', '-', '<cmd>Oil<cr>')

map('n', '<leader>g', '<cmd>Git<cr>')

map('n', '<leader>u', '<cmd>Undotree<cr>')

map('n', '<esc>', '<cmd>nohlsearch<cr>')

map('n', '<leader>ts', '<cmd>horizontal terminal<cr>')
map('n', '<leader>tv', '<cmd>vertical terminal<cr>')

map('n', '<leader>c', '<cmd>cc<cr>')

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
    if wininfo.quickfix == 1 and wininfo.tabnr == cur_tabnr then
      return vim.cmd.cclose()
    end
  end
  vim.cmd.copen()
end, { desc = 'Toggle quickfix window' })

map('n', '<leader>m', function()
  vim.ui.input({
    prompt = 'makeprg: ',
    default = vim.bo.makeprg,
    completion = 'shellcmdline',
  }, function(input)
    if input then
      vim.bo.makeprg = input
    end
  end)
end, { desc = 'Set makeprg' })

map('n', '<leader>s', function()
  vim.ui.input({
    prompt = 'b:start = ',
    default = vim.b.start,
    completion = 'shellcmdline',
  }, function(input)
    if input then
      vim.b.start = input
    end
  end)
end, { desc = 'Set b:start' })

map('n', '<leader>/', '<cmd>Pick grep_live<cr>')
map('n', '<leader>a', '<cmd>Pick buffers<cr>')
map('n', '<leader>f', '<cmd>Pick files<cr>')
map('n', '<leader>h', '<cmd>Pick help<cr>')
map('n', '<leader>n', '<cmd>Pick nvim<cr>')
map('n', '<leader>r', '<cmd>Pick resume<cr>')

map('n', '<leader>wd', '<cmd>lua MiniSessions.select("delete")<cr>')
map('n', '<leader>wn', '<cmd>lua MiniSessions.write(vim.fn.input("Session name: "))<cr>')
map('n', '<leader>wr', '<cmd>lua MiniSessions.select("read")<cr>')
map('n', '<leader>ww', '<cmd>lua MiniSessions.write()<cr>')

-- PLUGINS =====================================================================

require('mini.ai').setup()
require('mini.completion').setup()
require('mini.icons').setup()
require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.surround').setup()

local snippets = require('mini.snippets')
snippets.setup({
  snippets = {
    snippets.gen_loader.from_lang(),
  },
})

vim.ui.select = MiniPick.ui_select

MiniPick.registry.nvim = function()
  return MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath('config') } })
end

local wipeout_cur = function()
  vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, { force = true })
end
local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }
MiniPick.registry.buffers = function()
  return MiniPick.builtin.buffers(nil, { mappings = buffer_mappings })
end

require('oil').setup({
  columns = {
    'permissions',
    'mtime',
    'size',
    'icon',
  },
  keymaps = {
    ['<CR>'] = 'actions.select',
    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-t>'] = { 'actions.select', opts = { tab = true } },
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = { 'actions.close', mode = 'n' },
    ['<C-l>'] = 'actions.refresh',
    ['-'] = { 'actions.parent', mode = 'n' },
    ['_'] = { 'actions.open_cwd', mode = 'n' },
    ['='] = { 'actions.cd', mode = 'n' },
    ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
    ['gS'] = { 'actions.change_sort', mode = 'n' },
    ['gX'] = 'actions.open_external',
    ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
    ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
    ['<leader>f'] = {
      function()
        MiniPick.builtin.files(nil, { source = { cwd = require('oil').get_current_dir() } })
      end,
      mode = 'n',
      nowait = true,
      desc = 'Find files in the current directory',
    },
    ['<leader>/'] = {
      function()
        MiniPick.builtin.grep_live(nil, { source = { cwd = require('oil').get_current_dir() } })
      end,
      mode = 'n',
      nowait = true,
      desc = 'Grep live in the current directory',
    },
  },
  use_default_keymaps = false,
})

require('nvim-treesitter').install({ 'comment', 'diff' })

-- Autocommands ================================================================

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', {}),
  callback = function()
    vim.hl.on_yank()
  end,
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
      map('n', '<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = 'Toggle LSP inlay hints' })
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-autostart', {}),
  callback = function(ev)
    if pcall(vim.treesitter.get_parser, ev.buf) then
      vim.treesitter.start(ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('treesitter-update', {}),
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end,
})
