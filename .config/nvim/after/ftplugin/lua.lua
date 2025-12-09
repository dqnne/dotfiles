if vim.fn.executable('stylua') == 1 then
  vim.bo.formatprg = 'stylua -s --respect-ignores --stdin-filepath %:p -'
end
