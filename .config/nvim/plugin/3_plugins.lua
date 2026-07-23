require('mini.ai').setup()
require('mini.align').setup()
require('mini.completion').setup()
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
local diff_commit = function()
  local commit = pick.get_picker_matches().current:match('%x+')
  pick.stop()
  vim.schedule(function()
    vim.api.nvim_cmd({ cmd = 'Git', args = { 'difftool -y ' .. commit .. '~..' .. commit } }, {})
  end)
end
local commit_mappings = { yank = { char = '<c-y>', func = yank_hash }, diff = { char = '<c-d>', func = diff_commit } }
pick.registry.git_commits = function(local_opts)
  return extra.pickers.git_commits(local_opts, { mappings = commit_mappings })
end

local diff_hunk = function(scope)
  pick.default_choose(pick.get_picker_matches().current)
  pick.stop()
  if not scope or scope == 'unstaged' then
    vim.schedule(function()
      vim.api.nvim_cmd({ cmd = 'Gdiffsplit' }, {})
    end)
  elseif scope == 'staged' then
    vim.schedule(function()
      vim.api.nvim_cmd({ cmd = 'Gedit', args = { '@:%' } }, {})
      vim.api.nvim_cmd({ cmd = 'Gdiffsplit', args = { ':%' } }, {})
    end)
  end
end
pick.registry.git_hunks = function(local_opts)
  return extra.pickers.git_hunks(local_opts, {
    mappings = {
      diff = {
        char = '<c-d>',
        func = function()
          diff_hunk(local_opts.scope)
        end,
      },
    },
  })
end

require('nvim-treesitter').install({ 'comment', 'diff', 'regex' })

vim.g.guard_config = {
  fmt_on_save = false,
  lsp_as_default_formatter = true,
  save_on_fmt = false,
}

local ft = require('guard.filetype')
ft('lua'):fmt('stylua')
