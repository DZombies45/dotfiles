return { -- Autocompletion
  'saghen/blink.cmp',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/lua/snippets' })
          end,
        },
      },
    },
    -- Optional extra sources (lazydev, render-markdown register themselves
    -- as blink sources automatically if installed; no extra cmp-* glue needed)
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',

      ['<C-y>'] = { 'select_and_accept' },

      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },

      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
    },
  
    appearance = {
      -- 'mono' (default) for Nerd Font Mono or 'normal' for Nerd Font
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- Show documentation automatically
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = {
        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = { lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' } },
      providers = {
        lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Use the Rust fuzzy matcher implementation for max performance.
    -- If prebuilt binaries don't ship for your platform (e.g. some
    -- aarch64/Termux setups), uncomment the line below to fall back
    -- to the pure-Lua implementation instead of failing to load.
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      -- implementation = 'lua',
    },

    -- Experimental signature help support
    signature = { enabled = true },
  },
  opts_extend = { 'sources.default' },
}
