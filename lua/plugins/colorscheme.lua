return {
    { "catppuccin/nvim",           name = "catppuccin", priority = 1000 },
    { "atelierbram/Base2Tone-nvim" },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            transparent = true
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine"
    }
}
