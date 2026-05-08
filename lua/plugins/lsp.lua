return {
	-- { 'echasnovski/mini.completion', version = false },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- {
	--     "neovim/nvim-lspconfig",
	--     event = "VeryLazy",
	--     dependencies = {
	--         "williamboman/mason.nvim",
	--         "williamboman/mason-lspconfig.nvim",
	--         "hrsh7th/cmp-nvim-lsp",
	--     },
	-- },
	-- { 'L3MON4D3/LuaSnip',            dependencies = "rafamadriz/friendly-snippets" },
	-- { 'hrsh7th/nvim-cmp' },
	-- { 'hrsh7th/cmp-buffer' },
	-- { 'hrsh7th/cmp-path' },
	-- { 'saadparwaiz1/cmp_luasnip' },
	-- { 'rafamadriz/friendly-snippets' },
	-- { 'dmmulroy/tsc.nvim' }
}
