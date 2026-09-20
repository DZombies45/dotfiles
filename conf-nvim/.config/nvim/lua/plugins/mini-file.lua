return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function()
    -- mini.files is intentionally not enabled: Neo-tree is the primary explorer.
    local statusline = require('mini.statusline')
    statusline.setup({ use_icons = true })
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    require('mini.ai').setup({ n_lines = 500 })
    require('mini.surround').setup()
    require('mini.cursorword').setup()

    local hipatterns = require('mini.hipatterns')
    hipatterns.setup({
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
}
