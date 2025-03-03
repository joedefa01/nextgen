return {
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"tpope/vim-endwise",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				config = function()
					-- Init friendly snippets
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local lspconfig = require("lspconfig")
			local servers = { "clangd", "rust_analyzer", "pyright", "eslint", "ts_ls", "lua_ls", "gopls" }
			local luasnip = require("luasnip")
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			lspkind.init()

			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
				})
			end

			cmp.setup({
				window = {
					completion = {
						border = "rounded",
						scrollbar = "║",
					},
					documentation = {
						border = "rounded",
						scrollbar = "║",
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer", keyword_length = 5 },
				}),
				preselect = cmp.PreselectMode.None,
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						show_labelDetails = true,
						menu = {
							nvim_lua = "[api]",
							nvim_lsp = "[LSP]",
							path = "[path]",
							luasnip = "[snip]",
							buffer = "[buf]",
						},
					}),
				},
			})
		end,
	},
}
