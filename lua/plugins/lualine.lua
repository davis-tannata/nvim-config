local function format_kb(kb)
	if kb > 1024 * 1024 then
		return string.format("%.1fG", kb / 1024 / 1024)
	end
	return string.format("%dM", math.floor(kb / 1024))
end

local mem_text = ""

local function refresh_mem()
	vim.system({ "ps", "-eo", "pid,ppid,rss" }, { text = true }, function(res)
		if res.code ~= 0 or not res.stdout then
			return
		end

		local rss, children = {}, {}
		for line in res.stdout:gmatch("[^\n]+") do
			local pid, ppid, kb = line:match("^%s*(%d+)%s+(%d+)%s+(%d+)")
			if pid then
				pid, ppid, kb = tonumber(pid), tonumber(ppid), tonumber(kb)
				rss[pid] = kb
				children[ppid] = children[ppid] or {}
				table.insert(children[ppid], pid)
			end
		end

		local seen = {}
		local function sum(pid)
			if seen[pid] then
				return 0
			end
			seen[pid] = true
			local total = rss[pid] or 0
			for _, cpid in ipairs(children[pid] or {}) do
				total = total + sum(cpid)
			end
			return total
		end

		local total_kb = sum(vim.fn.getpid())
		vim.schedule(function()
			mem_text = " " .. format_kb(total_kb)
			pcall(function()
				require("lualine").refresh()
			end)
		end)
	end)
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_z = { function() return mem_text end },
			},
		})

		local timer = vim.uv.new_timer()
		timer:start(0, 3000, vim.schedule_wrap(refresh_mem))
	end,
}
