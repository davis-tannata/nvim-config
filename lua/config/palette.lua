local M = {}

-- user additions/removals persist here across sessions
local data_file = vim.fn.stdpath("data") .. "/custom-palette.json"

local function current_path()
    if vim.bo.filetype == "oil" then
        return require("oil").get_current_dir()
    end
    return vim.fn.expand("%:p")
end

function M.reveal_in_finder()
    local path = current_path()
    if not path or path == "" then return end
    if vim.fn.isdirectory(path) == 1 then
        vim.fn.jobstart({ "open", path }, { detach = true })
    else
        vim.fn.jobstart({ "open", "-R", path }, { detach = true })
    end
end

function M.copy_path()
    local path = current_path()
    if not path or path == "" then return end
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path)
end

function M.copy_relative_path()
    local path = current_path()
    if not path or path == "" then return end
    local rel = vim.fn.fnamemodify(path, ":.")
    vim.fn.setreg("+", rel)
    vim.notify("Copied: " .. rel)
end

local defaults = {
    { name = "Reveal in Finder      <leader>of", action = M.reveal_in_finder },
    { name = "Copy full path        <leader>cf", action = M.copy_path },
    { name = "Copy relative path    <leader>cr", action = M.copy_relative_path },
}

local function load_state()
    local ok, data = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(data_file), "\n"))
    end)
    if ok and type(data) == "table" then
        return { removed = data.removed or {}, custom = data.custom or {} }
    end
    return { removed = {}, custom = {} }
end

local function save_state(state)
    vim.fn.writefile({ vim.json.encode(state) }, data_file)
end

local function build_entries(state)
    local list = {}
    for _, d in ipairs(defaults) do
        if not vim.tbl_contains(state.removed, d.name) then
            list[#list + 1] = { name = d.name, action = d.action }
        end
    end
    for _, c in ipairs(state.custom) do
        list[#list + 1] = { name = c.name, cmd = c.cmd, custom = true }
    end
    return list
end

function M.open()
    local state = load_state()
    local items = build_entries(state)

    local lines = {}
    for i, item in ipairs(items) do
        lines[#lines + 1] = string.format(" %d  %s ", i, item.name)
    end
    lines[#lines + 1] = ""
    lines[#lines + 1] = " a add   d remove   q close "

    local width = 0
    for _, l in ipairs(lines) do width = math.max(width, #l) end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = #lines,
        row = math.floor((vim.o.lines - #lines) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = " Commands ",
        title_pos = "center",
    })

    local function close()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end

    local function run(i)
        local item = items[i]
        if not item then return end
        close()
        vim.schedule(function()
            if item.action then item.action() else vim.cmd(item.cmd) end
        end)
    end

    local function remove(i)
        local item = items[i]
        if not item then return end
        if item.custom then
            for idx, c in ipairs(state.custom) do
                if c.name == item.name then
                    table.remove(state.custom, idx)
                    break
                end
            end
        else
            state.removed[#state.removed + 1] = item.name
        end
        save_state(state)
        close()
        vim.schedule(M.open)
    end

    local function add()
        close()
        vim.schedule(function()
            vim.ui.input({ prompt = "Command name: " }, function(name)
                if not name or name == "" then return end
                vim.ui.input({ prompt = "Ex command (e.g. Oil, FzfLua files): " }, function(cmd)
                    if not cmd or cmd == "" then return end
                    state.custom[#state.custom + 1] = { name = name, cmd = cmd }
                    save_state(state)
                    M.open()
                end)
            end)
        end)
    end

    for i = 1, math.min(#items, 9) do
        vim.keymap.set("n", tostring(i), function() run(i) end, { buffer = buf, nowait = true })
    end
    vim.keymap.set("n", "<CR>", function() run(vim.api.nvim_win_get_cursor(0)[1]) end, { buffer = buf })
    vim.keymap.set("n", "d", function() remove(vim.api.nvim_win_get_cursor(0)[1]) end, { buffer = buf, nowait = true })
    vim.keymap.set("n", "a", add, { buffer = buf, nowait = true })
    vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true })
    vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
end

return M
