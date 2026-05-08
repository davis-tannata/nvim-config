vim.g.fzf_preview_command = "bat --theme kanagawa --color always --plain {-1}"
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
vim.keymap.set('n', '<leader>pv', '<CMD>Oil<CR>', { desc = "Open floating oil on current directory" })
function EditLineFromLazygit(file_path, line)
    local path = vim.fn.expand("%:p")
    if path == file_path then
        vim.cmd(tostring(line))
    else
        vim.cmd("e " .. file_path)
        vim.cmd(tostring(line))
    end
end

function EditFromLazygit(file_path)
    local path = vim.fn.expand("%:p")
    if path == file_path then
        return
    else
        vim.cmd("e " .. file_path)
    end
end

vim.opt.isfname:append(":") -- make : part of filenames
vim.opt.isfname:append(".") -- ensure .ts/.js recognized

-- Enable mouse clicks
vim.o.mouse = "a"
