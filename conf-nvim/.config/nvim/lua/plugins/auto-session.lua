return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require('auto-session')

    auto_session.setup({
      auto_restore = false,
      root_dir = vim.fn.stdpath('data') .. '/sessions/',
      suppressed_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
    })

    local keymap = vim.keymap

    keymap.set('n', '<leader>wr', '<cmd>AutoSession restore<CR>', { desc = 'Restore session for cwd' }) -- restore last workspace session for current directory
    keymap.set('n', '<leader>ww', '<cmd>AutoSession save<CR>', { desc = 'Save session for auto session root dir' }) -- save workspace session for current working directory
    keymap.set('n', '<leader>wd', '<cmd>AutoSession delete<CR>', { desc = 'Delete session' })
    keymap.set('n', '<leader>wf', '<cmd>AutoSession search<CR>', { desc = 'Search sessions' })
  end,
}
