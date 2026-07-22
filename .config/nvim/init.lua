vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/nvimdev/guard-collection',
  'https://github.com/nvimdev/guard.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/tpope/vim-dispatch',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-sleuth',
})

vim.cmd.packadd('nvim.undotree')

require('vim._core.ui2').enable({})

vim.cmd.colorscheme('custom')
