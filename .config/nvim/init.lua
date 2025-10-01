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

-- Editing
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

-- UI
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

map('n', '<leader>o', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
map('n', '<leader>d', vim.diagnostic.setqflist, { desc = 'Add diagnostics to quickfix list' })

map('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'Explore directory' })

map('n', '<esc>', '<cmd>nohlsearch<cr>')

map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })

map('n', 'gq<cr>', 'mzgggqG`z', { desc = 'Format buffer' })
map('n', 'gq?', '<cmd>set formatprg? formatexpr?<cr>', { desc = 'Formatter status' })

map('x', '<', '<gv', { desc = 'Shift left (keep selection)' })
map('x', '>', '>gv', { desc = 'Shift right (keep selection)' })

map('n', '<c-left>', '<c-w>5<', { desc = 'Decrease window width' })
map('n', '<c-down>', '<c-w>-', { desc = 'Decrease window height' })
map('n', '<c-up>', '<c-w>+', { desc = 'Increase window height' })
map('n', '<c-right>', '<c-w>5>', { desc = 'Increase window width' })


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

-- Picker ----------------------------------------------------------------------
map('n', '<leader>/', '<cmd>Pick grep_live<cr>', { desc = 'Grep live' })
map('n', '<leader>a', '<cmd>Pick buffers<cr>', { desc = 'Pick buffers' })
map('n', '<leader>f', '<cmd>Pick files<cr>', { desc = 'Pick files' })
map('n', '<leader>h', '<cmd>Pick help<cr>', { desc = 'Pick help' })
map('n', '<leader>n', '<cmd>Pick nvim<cr>', { desc = 'Pick nvim config files' })
map('n', '<leader>r', '<cmd>Pick resume<cr>', { desc = 'Pick resume' })

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

-- Mini ------------------------------------------------------------------------
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

-- Treesitter ------------------------------------------------------------------
-- Ensure installed
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
    map({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP code action' })
    map('n', '<leader>lD', vim.lsp.buf.declaration, { desc = 'LSP declaration' })
    map('n', '<leader>lS', vim.lsp.buf.document_symbol, { desc = 'LSP document symbols' })
    map('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'LSP definition' })
    map('n', '<leader>ln', vim.lsp.buf.rename, { desc = 'LSP rename' })
    map('n', '<leader>lr', vim.lsp.buf.references, { desc = 'LSP references' })
    map('n', '<leader>ls', vim.lsp.buf.workspace_symbol, { desc = 'LSP workspace symbols' })
    map('n', '<leader>lt', vim.lsp.buf.type_definition, { desc = 'LSP type definition' })

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/inlayHint', ev.buf) then
      map(
        'n',
        '<leader>lh',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        { desc = 'LSP toggle inlay hints' }
      )
    end
  end,
})

-- Autostart highlighting if parser exists
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-autostart', {}),
  callback = function(ev)
    if pcall(vim.treesitter.get_parser, ev.buf) then vim.treesitter.start(ev.buf) end
  end,
})

-- Treesitter update hook
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('treesitter-update', {}),
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then vim.cmd('TSUpdate') end
  end,
})
