local map = vim.keymap.set

map('n', '<leader>u', '<cmd>Undotree<cr>')

map('n', '<esc>', '<cmd>nohlsearch<cr>')

map('n', '<leader>ts', '<cmd>horizontal terminal<cr>')
map('n', '<leader>tv', '<cmd>vertical terminal<cr>')

map('x', '<', '<gv')
map('x', '>', '>gv')

map('n', '<leader>ee', ':e %:p:h/<tab>')
map('n', '<leader>es', ':sp %:p:h/<tab>')
map('n', '<leader>ev', ':vs %:p:h/<tab>')

map('n', '<leader>i', ':cd %:p:h<tab>')

map('n', '<c-left>', '<c-w>5<')
map('n', '<c-down>', '<c-w>-')
map('n', '<c-up>', '<c-w>+')
map('n', '<c-right>', '<c-w>5>')

map('c', '<c-a>', '<home>')
map('c', '<c-b>', '<left>')
map('c', '<c-f>', '<right>')
map('c', '<c-x><c-a>', '<c-a>')
map('c', '<c-x><c-f>', '<c-f>')

map('n', '<leader>qd', vim.diagnostic.setqflist)
map('n', '<leader>qt', function()
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
    default = vim.api.nvim_get_option_value('makeprg', {}),
    completion = 'shellcmdline',
  }, function(input)
    if input then
      vim.api.nvim_set_option_value('makeprg', input, {})
    end
  end)
end, { desc = 'Set makeprg' })

map('n', '<leader>s', function()
  vim.ui.input({
    prompt = 'Start command: ',
    default = vim.b.start,
    completion = 'shellcmdline',
  }, function(input)
    if input then
      vim.b.start = input
    end
  end)
end, { desc = 'Set b:start' })

map({ 'n', 'x' }, '<leader>z', '<cmd>Guard fmt<cr>')

map('n', "<c-'>", ':Start -wait=always ')

map('n', '<leader>fa', '<cmd>Pick buffers<cr>')
map('n', '<leader>ff', '<cmd>Pick files<cr>')
map('n', '<leader>fg', '<cmd>Pick grep_live<cr>')
map('n', '<leader>fh', '<cmd>Pick help<cr>')
map('n', '<leader>fn', '<cmd>Pick nvim<cr>')
map('n', '<leader>fo', '<cmd>Pick oldfiles<cr>')
map('n', '<leader>fr', '<cmd>Pick resume<cr>')

map('n', '<leader>gc', '<cmd>Pick git_commits<cr>')
map('n', '<leader>gC', '<cmd>Pick git_commits path="%"<cr>')
map('n', '<leader>gh', '<cmd>Pick git_hunks scope="unstaged"<cr>')
map('n', '<leader>gH', '<cmd>Pick git_hunks scope="staged"<cr>')

map('n', '<leader>wd', '<cmd>lua MiniSessions.select("delete")<cr>')
map('n', '<leader>wn', '<cmd>lua MiniSessions.write(vim.fn.input("Session name: "))<cr>')
map('n', '<leader>wr', '<cmd>lua MiniSessions.select("read")<cr>')
map('n', '<leader>ww', '<cmd>lua MiniSessions.write()<cr>')
