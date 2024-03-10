return {
	{
		"williamboman/mason.nvim", -- configuring mason plugin
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({ -- mason interacts with another plugin called as 'lspconfig'** internally to manage LSP servers
				ensure_installed = { "lua_ls", "gopls", "golangci_lint_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig", -- **this is the 'lspconfig' plugin to manage LSP servers
		config = function()
			local lspconfig = require("lspconfig")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["gopls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					gopls = {
						analyses = {
							assign = true,
							atomic = true,
							bools = true,
							composites = true,
							copylocks = true,
							deepequalerrors = true,
							embed = true,
							errorsas = true,
							fieldalignment = true,
							httpresponse = true,
							ifaceassert = true,
							loopclosure = true,
							lostcancel = true,
							nilfunc = true,
							nilness = true,
							nonewvars = true,
							printf = true,
							shadow = true,
							shift = true,
							simplifycompositelit = true,
							simplifyrange = true,
							simplifyslice = true,
							sortslice = true,
							stdmethods = true,
							stringintconv = true,
							structtag = true,
							testinggoroutine = true,
							tests = true,
							timeformat = true,
							unmarshal = true,
							unreachable = true,
							unsafeptr = true,
							unusedparams = true,
							unusedresult = true,
							unusedvariable = true,
							unusedwrite = true,
							useany = true,
						},
						hoverKind = "FullDocumentation",
						linkTarget = "pkg.go.dev",
						usePlaceholders = true,
						vulncheck = "Imports",
					},
				},
			})

			lspconfig.golangci_lint_ls.setup({
				capabilities = capabilities,
			})
		end,
	},
}
