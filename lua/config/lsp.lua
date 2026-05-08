-- use CoC


--[[
-- NOTE: to make any of this work you need a language server.
-- If you don't know what that is, watch this 5 min video:
-- https://www.youtube.com/watch?v=LaS32vctfOY

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config

local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig_defaults.capabilities = vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, capabilities)

-- This is where you enable features that only work
-- if there is a language server active in the file
-- Define a function to run whenever an LSP attaches to a buffer
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }

	-- Keymaps
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "x" }, "<F3>", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
	vim.keymap.set("n", "<F4>", "<cmd>FzfLua lsp_code_actions<CR>", { noremap = true, silent = true })
end

-- Apply on_attach to all servers by default
-- Apply defaults to ALL servers
vim.lsp.config("*", {
	on_attach = on_attach,
})

require("mason").setup({})
local servers = {
	bashls = {
		filetypes = { "sh", "zsh" },
	},
	cssls = {},
	eslint = {
		filetypes = { "javascript", "typescript", "vue" },
	},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = "Disable" },
			telemetry = { enable = false },
		},
	},
	tailwindcss = {
		suggestions = false,
		filetypes = { "css", "eruby", "html", "postcss", "vue" },
	},
	-- ts_ls = {},
}

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false, -- The key setting to prevent updates while typing
})

vim.lsp.config("eslint_lsp", {
	flags = {
		-- The key setting to minimize lag
		debounce_text_changes = 500, -- Delay in milliseconds (e.g., 500ms)
		-- This setting might also help by avoiding the server sending incremental changes
		allow_incremental_sync = false,
	},
	-- ... other eslint_lsp settings
})

-- ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_enable = vim.tbl_keys(servers),
})

-- for server_name, config in pairs(servers) do
--     local server_settings = servers[server_name] or {}
--     vim.lsp.config(server_name, {
--         capabilities = capabilities,
--         settings = server_settings,
--         filetypes = config.filetypes,
--     })
-- end

-- require('mason-lspconfig').setup{
--     ensure_installed = { 'eslint', 'html', 'cssls', 'tailwindcss' }
-- }

local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}
local vtsls_config = {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = tsserver_filetypes,
}

local ts_ls_config = {
	init_options = {
		plugins = {
			vue_plugin,
		},
	},
	filetypes = tsserver_filetypes,
}

-- If you are on most recent `nvim-lspconfig`
local vue_ls_config = {}

vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
-- vim.lsp.config("ts_ls", ts_ls_config)
vim.lsp.enable({ "vtsls", "vue_ls" }) -- If using `ts_ls` replace `vtsls` to `ts_ls`
-- local capabilities = require("mini.completion").completefunc_lsp()
-- local lspconfig = require("lspconfig")
-- local util = require("lspconfig.util")
-- local mason_registry = require("mason-registry")
-- local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
--     .. "/node_modules/@vue/language-server"
-- js, ts
-- lspconfig.ts_ls.setup({
--     init_options = {
--         plugins = {
--             {
--                 name = "@vue/typescript-plugin",
--                 location = vue_language_server_path,
--                 languages = { "vue" },
--             },
--         },
--     },
--     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
-- })
-- -- vue

--lua
-- require("lspconfig").lua_ls.setup({
-- 	on_init = function(client)
-- 		if client.workspace_folders then
-- 			local path = client.workspace_folders[1].name
-- 			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
-- 				return
-- 			end
-- 		end
--
-- 		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using
-- 				-- (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 			},
-- 			-- Make the server aware of Neovim runtime files
-- 			workspace = {
-- 				checkThirdParty = false,
-- 				library = {
-- 					vim.env.VIMRUNTIME,
-- 					-- Depending on the usage, you might want to add additional paths here.
-- 					-- "${3rd}/luv/library"
-- 					-- "${3rd}/busted/library",
-- 				},
-- 				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
-- 				-- library = vim.api.nvim_get_runtime_file("", true)
-- 			},
-- 		})
-- 	end,
-- 	settings = {
-- 		Lua = {},
-- 	},
-- })

]] --
--[[
local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<Enter>"] = cmp.mapping.confirm({ select = true }),

		-- Ctrl+Space to trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		-- jump to the next snippet placeholder
		["<C-f>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- jump to the previous snippet placeholder
		["<C-b>"] = cmp.mapping(function(fallback)
			local luasnip = require("luasnip")
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
})
]] --

-- local opts = { noremap = true, silent = true }
--
-- -- Hover (still Coc)
-- vim.keymap.set("n", "K", "<Plug>(coc-hover)", opts)
--
-- -- Go to definition via fzf-preview RPC
-- vim.keymap.set("n", "gd", "<cmd>FzfPreviewRPC coc_definitions<CR>", opts)
--
-- -- Go to declaration via fzf-preview RPC
-- vim.keymap.set("n", "gD", "<cmd>FzfPreviewRPC coc_declarations<CR>", opts)
--
-- -- Go to implementation via fzf-preview RPC
-- vim.keymap.set("n", "gi", "<cmd>FzfPreviewRPC coc_implementations<CR>", opts)
--
-- -- Go to type definition via fzf-preview RPC
-- vim.keymap.set("n", "go", "<cmd>FzfPreviewRPC coc_type_definitions<CR>", opts)
--
-- -- References via fzf-preview RPC
-- vim.keymap.set("n", "gr", "<cmd>FzfPreviewRPC coc_references<CR>", opts)
--
-- -- Signature help (still Coc)
-- vim.keymap.set("n", "gs", "<Plug>(coc-signature-help)", opts)
--
-- -- Rename (still Coc)
-- vim.keymap.set("n", "<F2>", "<Plug>(coc-rename)", opts)
--
-- -- Format (normal + visual)
-- vim.keymap.set({ "n", "x" }, "<F3>", "<Plug>(coc-format-selected)", opts)
--
-- -- Code actions via fzf-preview RPC
-- vim.keymap.set("n", "<F4>", "<cmd>FzfPreviewRPC coc_code_actions<CR>", opts)
