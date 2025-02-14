return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function () 
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "typescript","c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
			sync_install = false,
			highlight = { enable = true ,additional_vim_regex_highlighting =  false },
			auto_install = true,

		})
	end
}
