--arrow
vim.keymap.set("n", "H", require("arrow.persist").previous)
vim.keymap.set("n", "L", require("arrow.persist").next)

--telescope
local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>pf', fzf.files, { desc = 'fzf find files' })
vim.keymap.set('n', '<leader>pg', fzf.live_grep, { desc = 'fzf live grep' })
vim.keymap.set('n', '<leader>pb', fzf.buffers, { desc = 'fzf buffers' })
vim.keymap.set('n', '<leader>pgf', fzf.git_files, { desc = 'git files' })
vim.keymap.set('n', '<leader>pd', '<cmd>FzfLua diagnostics_workspace<cr>', { desc = 'Workspace diagnostic' })
--undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

--fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

--lazygit
vim.keymap.set('n', '<leader>lg', ':terminal lazygit <cr> | :startinsert <cr>')


--move
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')


vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', "\"_dP")

vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")

vim.keymap.set('n', '<leader>d', "\"_d")
vim.keymap.set('v', '<leader>d', "\"_d")

vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", function()
--     vim.lsp.buf.format()
-- end)
local conform = require("conform")
vim.keymap.set("n", "<leader>f", function()
    conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    desc =
    'replace current string'
})
vim.keymap.set("n", "<leader>XX", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float(0,{scope= 'line'})<CR>")
