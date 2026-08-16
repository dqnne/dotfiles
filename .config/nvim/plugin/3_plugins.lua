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

snippets.setup({ snippets = { snippets.gen_loader.from_lang() } })

vim.ui.select = pick.ui_select

pick.registry.nvim = function() return pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath('config') } }) end

local wipeout_cur = function() vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, { force = true }) end

local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }

pick.registry.buffers = function() return pick.builtin.buffers(nil, { mappings = buffer_mappings }) end

pick.registry.git_commits = function(local_opts)
  local git_dir = vim.fs.root(0, '.git')
  assert(git_dir, 'Git root not found.')
  local git_relpath = local_opts.path and vim.fs.relpath(git_dir, local_opts.path)
  local line1, line2 = local_opts.line1, local_opts.line2
  local range = (line1 and git_relpath) and line1 .. ',' .. line2 .. ':' .. git_relpath

  local preview = function(buf_id, item)
    vim.api.nvim_buf_call(buf_id, function()
      vim.schedule(
        function()
          vim.api.nvim_cmd({
            cmd = 'Git',
            args = { '++curwin show ' .. item:match('^(%x+)') .. ' -- ' .. (git_relpath or '') },
          })
        end
      )
    end)
  end
  local choose = function(item)
    local win_target = pick.get_picker_state().windows.target
    vim.api.nvim_win_call(win_target, function()
      vim.schedule(
        function()
          vim.api.nvim_cmd({
            cmd = 'Git',
            args = { '++curwin show ' .. item:match('^(%x+)') .. ' -- ' .. (git_relpath or '') },
          })
        end
      )
    end)
  end
  local yank_hash = function()
    local register = vim.o.clipboard:find('unnamedplus') and '+' or vim.o.clipboard:find('unnamed') and '*' or '"'
    vim.fn.setreg(register, pick.get_picker_matches().current:match('^(%x+)'))
  end
  local diff_commit = function()
    local commit = pick.get_picker_matches().current:match('^(%x+)')
    pick.stop()
    vim.schedule(
      function()
        vim.api.nvim_cmd({
          cmd = 'Git',
          args = { 'difftool -y ' .. commit .. '~..' .. commit .. ' -- ' .. (git_relpath or '') },
        })
      end
    )
  end

  local command = { 'git', 'log', '--format=format:%h %s' }
  if range then
    table.insert(command, '--no-patch')
    table.insert(command, '-L ' .. range)
  elseif git_relpath then
    table.insert(command, '--')
    table.insert(command, git_relpath)
  end
  local name = string.format('Git commits (%s)', range or git_relpath or 'all')
  local source = { name = name, cwd = git_dir, preview = preview, choose = choose }

  return pick.builtin.cli({ command = command }, {
    source = source,
    mappings = { yank = { char = '<c-y>', func = yank_hash }, diff = { char = '<c-d>', func = diff_commit } },
  })
end

local diff_hunk = function(scope)
  pick.default_choose(pick.get_picker_matches().current)
  pick.stop()
  if not scope or scope == 'unstaged' then
    vim.schedule(function() vim.api.nvim_cmd({ cmd = 'Gdiffsplit' }, {}) end)
  elseif scope == 'staged' then
    vim.schedule(function()
      vim.api.nvim_cmd({ cmd = 'Gtabedit', args = { '@:%' } }, {})
      vim.api.nvim_cmd({ cmd = 'Gdiffsplit', args = { ':%' } }, {})
    end)
  end
end

pick.registry.git_hunks = function(local_opts)
  return extra.pickers.git_hunks(
    local_opts,
    { mappings = { diff = { char = '<c-d>', func = function() diff_hunk(local_opts.scope) end } } }
  )
end

vim.api.nvim_create_user_command(
  'GpLog',
  function(args) pick.registry.git_commits({ line1 = args.line1, line2 = args.line2, path = vim.fn.expand('%') }) end,
  { range = true }
)

require('nvim-treesitter').install({ 'comment', 'diff', 'regex' })

vim.g.guard_config = { fmt_on_save = false, lsp_as_default_formatter = true, save_on_fmt = false }

local ft = require('guard.filetype')
ft('lua'):fmt('stylua')
