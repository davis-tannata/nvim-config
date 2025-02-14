require("config.lazy")
require("config.set")
require("config.keymaps")
require("config.lsp")
require("oil").setup({
    view_options = {
        show_hidden = true
    }
})
vim.opt.splitright = true
vim.keymap.set('n','<leader>pv','<CMD>Oil<CR>', {desc = "Open floating oil on current directory"})
