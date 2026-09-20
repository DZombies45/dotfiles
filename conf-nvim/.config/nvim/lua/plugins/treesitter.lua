return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    local treesitter = require('nvim-treesitter')

    -- nvim-treesitter main is the Neovim 0.12 rewrite.
    treesitter.setup({
      install_dir = vim.fn.stdpath('data') .. '/site',
    })

    treesitter.install({
      'bash',
      'css',
      'gitignore',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'tsx',
      'typescript',
      'vim',
      'yaml',
    })

    require('nvim-ts-autotag').setup({
      enable = true,
      filetypes = { 'html', 'xml', 'javascriptreact', 'typescriptreact', 'tsx' },
    })

    local ts_filetypes = {
      'bash',
      'css',
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'lua',
      'markdown',
      'markdown_inline',
      'tsx',
      'typescript',
      'typescriptreact',
      'yaml',
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ts_filetypes,
      callback = function()
        -- Highlighting is enabled per buffer in the 0.12 Treesitter API.
        pcall(vim.treesitter.start)

        -- Keep folds lightweight; don't force a fold level open/closed policy.
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- Treesitter indentation is useful for code buffers, but not markdown.
        if vim.bo.filetype ~= 'markdown' and vim.bo.filetype ~= 'markdown_inline' then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
