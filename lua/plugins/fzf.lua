-- ~/.config/nvim/lua/plugins/fzf-preview.lua
return {
    "yuki-yano/fzf-preview.vim",
    branch = "release/rpc",
    dependencies = { "junegunn/fzf", 'ryanoasis/vim-devicons' }, -- make sure fzf is installed
    config = function()
        -- Optional: default settings
        vim.g.fzf_preview_preview_window = { "right:50%" }
    end,
}
