--arrow
vim.keymap.set("n", "H", require("arrow.persist").previous)
vim.keymap.set("n", "L", require("arrow.persist").next)

--telescope
local fzf = require("fzf-lua")
-- fzf.register_ui_select()
vim.keymap.set("n", "<leader>pf", fzf.files, { desc = "fzf find files" })
vim.keymap.set("n", "<leader>pg", fzf.live_grep, { desc = "fzf live grep" })
vim.keymap.set("n", "<leader>pb", fzf.buffers, { desc = "fzf buffers" })
-- vim.keymap.set("n", "<leader>pgf", fzf.git_files, { desc = "git files" })
-- vim.keymap.set("n", "<leader>pd", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Workspace diagnostic" })

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

local opts = { noremap = true, silent = true }

-- vim.keymap.set('i', '<CR>', function()
--     return vim.fn['coc#pum#visible']() == 1 and vim.fn['coc#pum#confirm']() or '\n'
-- end, opts)

vim.keymap.set("i", "<C-Space>", "coc#refresh()", { expr = true, noremap = true, silent = true })

-- Project / Git / Directory / Buffers
-- vim.keymap.set("n", "<leader>pf", "<cmd>CocCommand fzf-preview.ProjectFiles<CR>", opts)
vim.keymap.set("n", "<leader>pgf", "<cmd>CocCommand fzf-preview.GitFiles<CR>", opts)
vim.keymap.set("n", "<leader>pgd", "<cmd>CocCommand fzf-preview.DirectoryFiles<CR>", opts)
-- vim.keymap.set("n", "<leader>pb", "<cmd>CocCommand fzf-preview.Buffers<CR>", opts)
vim.keymap.set("n", "<leader>pba", "<cmd>CocCommand fzf-preview.AllBuffers<CR>", opts)

-- Old / MRU / MRW
vim.keymap.set("n", "<leader>po", "<cmd>CocCommand fzf-preview.ProjectOldFiles<CR>", opts)
vim.keymap.set("n", "<leader>pmru", "<cmd>CocCommand fzf-preview.ProjectMruFiles<CR>", opts)
vim.keymap.set("n", "<leader>pmrw", "<cmd>CocCommand fzf-preview.ProjectMrwFiles<CR>", opts)
vim.keymap.set("n", "<leader>mo", "<cmd>CocCommand fzf-preview.OldFiles<CR>", opts)
vim.keymap.set("n", "<leader>mmru", "<cmd>CocCommand fzf-preview.MruFiles<CR>", opts)
vim.keymap.set("n", "<leader>mmrw", "<cmd>CocCommand fzf-preview.MrwFiles<CR>", opts)

-- Grep / Recall
-- vim.keymap.set("n", "<leader>pg", "<cmd>CocCommand fzf-preview.ProjectGrep .<CR>", opts)
vim.keymap.set("n", "<leader>pgr", "<cmd>CocCommand fzf-preview.ProjectGrepRecall<CR>", opts)

-- Tags / Ctags / Buffer tags
vim.keymap.set("n", "<leader>ct", "<cmd>CocCommand fzf-preview.Ctags<CR>", opts)
vim.keymap.set("n", "<leader>bt", "<cmd>CocCommand fzf-preview.BufferTags<CR>", opts)

-- QuickFix / LocationList / Lines
vim.keymap.set("n", "<leader>qf", "<cmd>CocCommand fzf-preview.QuickFix<CR>", opts)
vim.keymap.set("n", "<leader>ql", "<cmd>CocCommand fzf-preview.LocationList<CR>", opts)
vim.keymap.set("n", "<leader>ll", "<cmd>CocCommand fzf-preview.Lines<CR>", opts)
vim.keymap.set("n", "<leader>bl", "<cmd>CocCommand fzf-preview.BufferLines<CR>", opts)

-- Jumps / Changes / Marks
vim.keymap.set("n", "<leader>jj", "<cmd>CocCommand fzf-preview.Jumps<CR>", opts)
vim.keymap.set("n", "<leader>ch", "<cmd>CocCommand fzf-preview.Changes<CR>", opts)
vim.keymap.set("n", "<leader>mm", "<cmd>CocCommand fzf-preview.Marks<CR>", opts)

-- Command Palette
vim.keymap.set("n", "<leader>cp", "<cmd>CocCommand fzf-preview.CommandPalette<CR>", opts)

-- Coc LSP
-- vim.keymap.set("n", "gr", "<cmd>CocCommand fzf-preview.CocReferences<CR>", opts)
vim.keymap.set("n", "gr", "<Plug>(coc-references)", opts)
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", opts)
vim.keymap.set("n", "<leader>pd", "<cmd>CocCommand fzf-preview.CocDiagnostics<CR>", opts)
vim.keymap.set("n", "gi", "<cmd>CocCommand fzf-preview.CocImplementations<CR>", opts)
vim.keymap.set("n", "go", "<cmd>CocCommand fzf-preview.CocTypeDefinition<CR>", opts)
vim.keymap.set("n", "gs", "<cmd>CocCommand fzf-preview.CocCurrentDiagnostics<CR>", opts)
vim.keymap.set("n", "<leader>co", "<cmd>CocCommand fzf-preview.CocOutline<CR>", opts)
vim.keymap.set("n", "<F4>", "<Plug>(coc-codeaction)")

--Flutter spesific
vim.keymap.set("n", "<leader>fs", "<cmd>CocCommand flutter.run<CR>",
    vim.tbl_extend("force", opts, { desc = "Flutter Run" }))

vim.keymap.set("n", "<leader>fa", "<cmd>CocCommand flutter.attach<CR>",
    vim.tbl_extend("force", opts, { desc = "Flutter Attach" }))

vim.keymap.set("n", "<leader>fq", "<cmd>CocCommand flutter.dev.quit<CR>",
    vim.tbl_extend("force", opts, { desc = "Flutter Quit" }))
vim.keymap.set("n", "<leader>fr", "<cmd>CocCommand flutter.dev.hotRestart<CR>",
    vim.tbl_extend("force", opts, { desc = "Flutter Restart" }))
vim.keymap.set("n", "<leader>fd", "<cmd>CocCommand flutter.devices<CR>",
    vim.tbl_extend("force", opts, { desc = "Flutter Devices" }))

vim.keymap.set("n", "<leader>fe", "<cmd>CocCommand flutter.emulators<CR>",
    vim.tbl_extend("force", opts, { desc = "Flutter Emulators" }))

vim.keymap.set("n", "<leader>fk", ":!killall -9 dart<CR>",
    { desc = "Kill dart" })
--Use K to show documentation in preview window
vim.cmd([[
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
]])

vim.keymap.set("n", "<leader>pn", function()
    require("notify.integrations").pick()
end, { desc = "Pick a notification" })
--undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

--fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

--move
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", function()
--     vim.lsp.buf.format()
-- end)
-- local conform = require("conform")
-- vim.keymap.set("n", "<leader>f", function()
-- 	conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
-- end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--custom command palette (see lua/config/palette.lua)
local palette = require("config.palette")
vim.keymap.set("n", "<leader>of", palette.reveal_in_finder, { desc = "Reveal in Finder" })
vim.keymap.set("n", "<leader>cf", palette.copy_path, { desc = "Copy full path" })
vim.keymap.set("n", "<leader>cr", palette.copy_relative_path, { desc = "Copy path relative to cwd" })
vim.keymap.set("n", "<leader>cc", palette.open, { desc = "Custom command menu" })

-- Search and replace word under the cursor.
vim.keymap.set("n", "<Leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

vim.keymap.set("n", "<Esc>", "<cmd>nohls<CR>")
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//g<left><left>')
vim.keymap.set("n", "<leader>XX", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float(0,{scope= 'line'})<CR>")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        width = vim.o.columns,
        height = vim.o.lines,
        winblend = 0,
        border = "shadow",
    },
    persist_size = false
})

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>w", "mzgg=G`z<cmd>w<CR>")
--lazygit
-- vim.keymap.set('n', '<leader>lg', ':terminal lazygit <cr> | :startinsert <cr>')
