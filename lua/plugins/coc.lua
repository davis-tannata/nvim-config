return {
	{
		"neoclide/coc.nvim",
		branch = "release", -- Always use the 'release' branch for stability
		event = "BufReadPre", -- Load when opening a buffer, adjust as needed
		-- Recommended: disable/remove nvim-cmp and nvim-lspconfig setups if you're fully switching
		-- config = function()
		--   -- CoC.nvim requires its own configuration, typically in init.vim or through a coc-settings.json
		--   -- You'll likely need to configure it in init.vim for some parts or install extensions via :CocInstall
		--   -- For Lua-based configuration:
		--   -- require('coc-config') -- if you create a separate Lua module for CoC config
		-- end,
		build = "vim-patch:8.1.1398", -- Required for proper installation
		init = function()
			-- If you have existing cmp mappings, you might want to unmap them here
			-- to avoid conflicts, or only set CoC mappings if cmp is not loaded.
			-- E.g., vim.keymap.del("i", "<C-Space>")
		end,
		keys = {
			-- Example CoC keybindings (you'll customize these heavily)
			-- You might map <Tab> or <CR> for completion confirmation
			{ "<leader>gd", "<cmd>CocAction<CR>", mode = "n", desc = "Go to definition" },
			{ "<leader>gr", "<cmd>CocRename<CR>", mode = "n", desc = "Rename symbol" },
			-- Add many more as needed for CoC features
		},
	},
	-- You'll also need to install specific CoC extensions for language support,
	-- e.g., coc-tsserver for TypeScript, coc-html, coc-css, coc-json etc.
	-- These are typically installed interactively with :CocInstall,
	-- but you could potentially automate it if needed.
}
