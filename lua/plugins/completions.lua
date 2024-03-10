return {
	{
		-- code completions using LSP as source
		-- works out of the box with 'hrsh7th/nvim-cmp', no comfigurations needed
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		-- snippet manager
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		-- comprehensive completion framework for Neovim,
		-- integrating various completion sources: LSP, buffers, snippets
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			-- lazy load module responsible for loading vscode like snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					-- defines how snippets should be expanded when selected, this is just for lua
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
          --		["<C-b>"] = cmp.mapping.scroll_docs(-4),
					--		["<C-f>"] = cmp.mapping.scroll_docs(4),
					--    ["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),                   -- abort suggestion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- navigate and select options given by auto-complete

				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" }, -- buffer source provides suggestions based on the content of the current file
				}),
			})
		end,
	},
}
