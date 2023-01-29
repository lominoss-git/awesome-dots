require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'sumneko_lua',  }
})
local rt = require('rust-tools')

rt.setup({
    server = {
        on_attach = function (_, bufnr)
            -- vim.keymap.set('n', '<leader>ca', rt.code_actions_group.code_action_group, { buffer = bufnr })
            -- vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr })
        end,
    },
})

local lua_on_attach = function(_, _)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').sumneko_lua.setup {
    on_attach = lua_on_attach,
    capabilities = capabilities,
}
