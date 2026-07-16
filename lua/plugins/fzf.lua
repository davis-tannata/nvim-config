-- ~/.config/nvim/lua/plugins/fzf-preview.lua
return {
    "yuki-yano/fzf-preview.vim",
    branch = "release/rpc",
    dependencies = { "junegunn/fzf", 'ryanoasis/vim-devicons' }, -- make sure fzf is installed
    init = function()
        -- stop fzf-preview from remapping <Esc> to <C-g> in ALL fzf terminals
        -- (it broke closing fzf-lua pickers with escape)
        vim.g.fzf_preview_quit_map = 0
    end,
    config = function()
        -- Optional: default settings
        vim.g.fzf_preview_preview_window = { "right:50%" }
    end,
}
