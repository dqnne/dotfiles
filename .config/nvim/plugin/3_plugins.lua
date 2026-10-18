require('mini.ai').setup()
require('mini.align').setup()
require('mini.completion').setup()
require('mini.diff').setup()
require('mini.extra').setup()
require('mini.icons').setup()
require('mini.pairs').setup()
require('mini.sessions').setup()
require('mini.statusline').setup()

require('mini.operators').setup({ sort = { prefix = 'gS' } })

require('mini.surround').setup({
  mappings = {
    add = 'gsa',
    delete = 'gsd',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    replace = 'gsr',
  },
})

local pick, snippets = require('mini.pick'), require('mini.snippets')

snippets.setup({ snippets = { snippets.gen_loader.from_lang() } })

pick.setup({
  window = {
    config = function() return { border = 'solid', height = math.floor(vim.o.lines / 3), width = vim.o.columns } end,
  },
})

vim.ui.select = pick.ui_select

pick.registry.nvim = function() return pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath('config') } }) end

local wipeout_cur = function() vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, { force = true }) end

local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }

pick.registry.buffers = function() return pick.builtin.buffers(nil, { mappings = buffer_mappings }) end

require('nvim-treesitter').install({ 'comment', 'diff', 'regex' })

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_format' },
  },
})

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format({ async = true, lsp_format = 'fallback', range = range })
end, { range = true })

require('flash').setup({
  highlight = {
    backdrop = false,
  },
  modes = {
    char = {
      enabled = false,
    },
  },
})
