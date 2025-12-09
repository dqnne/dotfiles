if vim.fn.executable('ruff') == 1 then
  vim.bo.formatprg = 'ruff check -s --fix-only --stdin-filename %:p - | ruff format --stdin-filename %:p -'
end
