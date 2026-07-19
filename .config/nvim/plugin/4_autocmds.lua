local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set

local hl_ops_group = augroup('highlight-ops', {})
autocmd('TextYankPost', {
  group = hl_ops_group,
  callback = function()
    vim.hl.hl_op({ higroup = 'IncSearch' })
  end,
})
autocmd('TextPutPost', {
  group = hl_ops_group,
  callback = function()
    vim.hl.hl_op({ higroup = 'Visual' })
  end,
})

autocmd('LspAttach', {
  group = augroup('lsp', {}),
  callback = function(ev)
    map({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action)
    map('n', '<leader>li', '<cmd>Pick lsp scope="implementation"<cr>')
    map('n', '<leader>ln', vim.lsp.buf.rename)
    map('n', '<leader>lr', '<cmd>Pick lsp scope="references"<cr>')
    map('n', '<leader>ls', '<cmd>Pick lsp scope="workspace_symbol_live"<cr>')
    map('n', '<leader>lt', vim.lsp.buf.type_definition)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/inlayHint', ev.buf) then
      map('n', '<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = 'Toggle LSP inlay hints' })
    end
  end,
})

autocmd('PackChanged', {
  group = augroup('pack-hooks', {}),
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end,
})

autocmd('FileType', {
  group = augroup('treesitter-autostart', {}),
  callback = function(ev)
    if vim.treesitter.get_parser(ev.buf) then
      vim.treesitter.start(ev.buf)

      map({ 'n', 'x' }, '<c-/>', function()
        vim.treesitter.select('parent')
      end, { buf = ev.buf })
      map({ 'n', 'x' }, '<c-.>', function()
        vim.treesitter.select('child')
      end, { buf = ev.buf })
    end
  end,
})
