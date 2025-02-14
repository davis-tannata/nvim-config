return {
    "zeioth/none-ls-autoload.nvim",
    event = "BufEnter",
    dependencies = {
        "williamboman/mason.nvim",
        "zeioth/none-ls-external-sources.nvim"
    },
    opts = {
        -- Here you can add support for sources not oficially suppored by none-ls.
        external_sources = {
            -- diagnostics
            'none-ls-external-sources.diagnostics.cpplint',
            'none-ls-external-sources.diagnostics.eslint',
            'none-ls-external-sources.diagnostics.eslint_d',
            'none-ls-external-sources.diagnostics.flake8',
            'none-ls-external-sources.diagnostics.luacheck',
            'none-ls-external-sources.diagnostics.psalm',
            'none-ls-external-sources.diagnostics.yamllint',

            -- formatting
            'none-ls-external-sources.formatting.autopep8',
            'none-ls-external-sources.formatting.beautysh',
            'none-ls-external-sources.formatting.easy-coding-standard',
            'none-ls-external-sources.formatting.eslint',
            'none-ls-external-sources.formatting.eslint_d',
            'none-ls-external-sources.formatting.jq',
            'none-ls-external-sources.formatting.latexindent',
            'none-ls-external-sources.formatting.reformat_gherkin',
            'none-ls-external-sources.formatting.rustfmt',
            'none-ls-external-sources.formatting.standardrb',
            'none-ls-external-sources.formatting.yq',

            -- code actions
            'none-ls-external-sources.code_actions.eslint',
            'none-ls-external-sources.code_actions.eslint_d',
            'none-ls-external-sources.code_actions.shellcheck',
        },
    },
}
