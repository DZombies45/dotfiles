return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },  -- tambah event supaya tidak lazy terlalu awal
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()  -- ganti dari main + opts ke config eksplisit
    require('nvim-treesitter.config').setup({
      ensure_installed = {
        'javascript', 'typescript', 'sql', 'json', 'java',
        'gitignore', 'graphql', 'yaml', 'markdown', 'markdown_inline',
        'bash', 'css', 'html', 'vim', 'lua',  -- tambah lua, sering dibutuhkan
      },
      autotag = { enable = true },
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    })
  end,
}