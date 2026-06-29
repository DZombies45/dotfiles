return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
  opts = {},
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        lua = { 'stylua', 'prettier', stop_after_first = true },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 5000,
      },
    })

    conform.formatters.injected = {
      -- Set the options field
      options = {
        -- Use a specific prettier parser for a filetype
        -- Otherwise, prettier will try to infer the parser from the file name
        ft_parsers = {
          javascript = 'babel',
          javascriptreact = 'babel',
          typescript = 'typescript',
          typescriptreact = 'typescript',
          --     vue = "vue",
          css = 'css',
          --     scss = "scss",
          -- less = "less",
          html = 'html',
          json = 'json',
          --     jsonc = "json",
          yaml = 'yaml',
          markdown = 'markdown',
          --     ["markdown.mdx"] = "mdx",
          --     graphql = "graphql",
          --     handlebars = "glimmer",
        },
        -- Use a specific prettier parser for a file extension
        ext_parsers = {
          -- qmd = "markdown",
        },
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>ff', function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 2000,
      })
    end, { desc = 'Format file or range (in visual mode)' })

    -- vim.keymap.set("n", "<leader>f", function()
    --   require("conform").format({
    --     async = true,
    --     lsp_fallback = true,
    --     timeout_ms = 2000,
    --   })
    -- end, {
    --   desc = "Format file",
    -- })
  end,
}
