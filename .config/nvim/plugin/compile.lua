-- Set makeprg
local function set_makeprg()
  vim.ui.input({
    prompt = 'makeprg: ',
    default = vim.bo.makeprg,
    completion = 'shellcmdline',
  }, function(input)
    if input then vim.bo.makeprg = vim.fn.expandcmd(input) end
  end)
end

-- Run makeprg in pseudoterminal
local function compile()
  local cmd = vim.bo.makeprg
  local efm = vim.bo.errorformat

  local compile_bufnr = vim.api.nvim_create_buf(true, true)
  if compile_bufnr == 0 then return end

  vim.api.nvim_set_current_buf(compile_bufnr)

  vim.bo.makeprg = cmd
  vim.bo.errorformat = efm

  local lines = {}

  local function populate_qflist()
    vim.fn.setqflist({}, ' ', {
      efm = efm ~= '' and efm or nil,
      lines = lines,
      title = cmd,
    })
    vim.cmd.cc()
  end

  local function on_exit()
    lines = vim.api.nvim_buf_get_lines(compile_bufnr, 0, -1, false)
    vim.keymap.set('n', '<cr>', populate_qflist, { buffer = compile_bufnr })

    vim.api.nvim_create_autocmd('BufHidden', {
      buffer = compile_bufnr,
      once = true,
      callback = function(ev)
        vim.api.nvim_create_autocmd('BufEnter', {
          once = true,
          callback = function() vim.cmd.bw(ev.buf) end,
        })
      end,
    })
  end

  vim.fn.jobstart(cmd, {
    on_exit = on_exit,
    term = true,
  })
end

vim.api.nvim_create_user_command('Compile', compile, {})
vim.api.nvim_create_user_command('SetMakeprg', set_makeprg, {})
