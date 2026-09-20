return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    { 'mason-org/mason-lspconfig.nvim', opts = {} },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', opts = {} },
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    -- Native Neovim 0.12 LSP API. nvim-lspconfig now provides the server defaults
    -- consumed by vim.lsp.config(); require('lspconfig') is intentionally avoided.
    local servers = { 'ts_ls', 'jsonls', 'yamlls' }

    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
    end

    require('mason').setup()

    -- Mason is kept intentionally: it makes discovering/installing a new LSP
    -- much easier on a phone. Use :Mason or :LspInstall when a new filetype appears.
    require('mason-lspconfig').setup({
      ensure_installed = servers,
      automatic_enable = true,
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'eslint_d',
      },
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          vim.keymap.set(mode or 'n', keys, func, {
            buffer = event.buf,
            desc = 'LSP: ' .. desc,
          })
        end

        local telescope = require('telescope.builtin')

        map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
        map('gr', telescope.lsp_references, '[G]oto [R]eferences')
        map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local group = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.clear_references,
          })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })
  end,
}
