return {
    "nvimtools/none-ls.nvim",
    config = function()
        require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
}
