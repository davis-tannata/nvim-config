return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- You can customize some of the format options for the filetype (:help conform.format)
            rust = { "rustfmt", lsp_format = "fallback" },
            -- Conform will run the first available formatter
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd" },
            vue = { "prettierd" },
            css = { "prettierd" },
            scss = { "prettierd" },
            less = { "prettierd" },
            yaml = { "yamlfix" },
            markdown = { "prettierd" },
            html = { "htmlbeautifier" }
        },
        -- Set this to change the default values when calling conform.format()
        -- This will also affect the default values for format_on_save/format_after_save
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- If this is set, Conform will run the formatter on save.
        -- It will pass the table to conform.format().
        -- This can also be a function that returns the table.
        format_on_save = {
            -- I recommend these options. See :help conform.format for details.
            lsp_format = "fallback",
            timeout_ms = 500,
        },
        -- If this is set, Conform will run the formatter asynchronously after save.
        -- It will pass the table to conform.format().
        -- This can also be a function that returns the table.
        format_after_save = {
            lsp_format = "fallback",
        },
    },
}
