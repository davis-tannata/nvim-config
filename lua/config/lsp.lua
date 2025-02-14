-- NOTE: to make any of this work you need a language server.
-- If you don't know what that is, watch this 5 min video:
-- https://www.youtube.com/watch?v=LaS32vctfOY

-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})


require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
            })
        end,
    },
    ensure_installed = { 'volar', 'eslint', 'html', 'cssls', 'ts_ls', 'tailwindcss' }
})


local capabilities = require("mini.completion").completefunc_lsp()
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
    .. "/node_modules/@vue/language-server"
-- js, ts
lspconfig.ts_ls.setup({
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
            },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})
-- vue
local function get_vue_version()
    local root_dir = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()
    local package_json = root_dir .. "/package.json"

    if vim.fn.filereadable(package_json) == 1 then
        local package_data = vim.fn.json_decode(vim.fn.readfile(package_json))
        local vue_version = package_data["dependencies"] and package_data["dependencies"]["vue"]
            or package_data["devDependencies"] and package_data["devDependencies"]["vue"]

        if vue_version then
            -- Strip any non-numeric characters like ^ or ~ from the version string
            local cleaned_version = vim.fn.matchstr(vue_version, [[\v\d+]])
            local version = tonumber(cleaned_version)
            return version
        end
    end
    return nil
end

local vue_version = get_vue_version()

if vue_version == 3 then
    -- use volar for vue 3
    lspconfig.volar.setup({
        capabilities = capabilities,
    })
else
    -- use vetur (vuels) for vue 2
    -- lspconfig.vuels.setup({
    -- 	capabilities = capabilities,
    -- 	filetypes = { "vue" },
    -- 	root_dir = lspconfig.util.root_pattern("package.json", ".git"),
    -- })
end

--lua
require 'lspconfig'.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}

local cmp = require('cmp')

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        -- jump to the next snippet placeholder
        ['<C-f>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        -- jump to the previous snippet placeholder
        ['<C-b>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
})


require('tsc').setup()
