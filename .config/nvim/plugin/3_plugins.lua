require('mini.ai').setup()
require('mini.align').setup()
require('mini.completion').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.sessions').setup()
require('mini.statusline').setup()
require('mini.surround').setup()

local extra, pick, snippets = require('mini.extra'), require('mini.pick'), require('mini.snippets')
extra.setup()
pick.setup()

snippets.setup({
  snippets = {
    snippets.gen_loader.from_lang(),
  },
})

vim.ui.select = pick.ui_select

pick.registry.nvim = function()
  return pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath('config') } })
end

local wipeout_cur = function()
  vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, { force = true })
end
local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }
pick.registry.buffers = function()
  return pick.builtin.buffers(nil, { mappings = buffer_mappings })
end

local yank_hash = function()
  local register = vim.o.clipboard:find('unnamedplus') and '+' or vim.o.clipboard:find('unnamed') and '*' or '"'
  vim.fn.setreg(register, pick.get_picker_matches().current:match('%x+'))
end
local commit_mappings = { yank = { char = '<c-y>', func = yank_hash } }
pick.registry.git_commits = function()
  return extra.pickers.git_commits(nil, { mappings = commit_mappings })
end

require('nvim-treesitter').install({ 'comment', 'diff', 'regex' })

vim.g.diffs = {
  conflict = {
    keymaps = {
      ours = '<leader>co',
      theirs = '<leader>ct',
      both = '<leader>cb',
      none = '<leader>cn',
      next = ']x',
      prev = '[x',
    },
  },
}

vim.g.guard_config = {
  fmt_on_save = false,
  lsp_as_default_formatter = true,
  save_on_fmt = false,
}

local ft = require('guard.filetype')
ft('lua'):fmt('stylua')
