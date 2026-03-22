return {
	{
		"hrsh7th/nvim-cmp",
		-- Ładujemy ten plugin dopiero, gdy wejdziemy w tryb wstawiania (Insert mode), żeby Neovim uruchamiał się błyskawicznie
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- Źródło podpowiedzi z serwera LSP (nasz basedpyright)
			"hrsh7th/cmp-nvim-lsp",
			-- Źródło podpowiedzi z tekstu, który już jest w obecnym pliku
			"hrsh7th/cmp-buffer",
			-- Źródło podpowiedzi ścieżek do plików (np. gdy piszesz "./data/")
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- Silnik snippetów (wymagany przez nvim-cmp do działania)
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				-- nvim-cmp wymaga silnika snippetów, żeby wiedzieć, jak rozwijać niektóre funkcje
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				-- Skróty klawiszowe w okienku autouzupełniania
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- Strzałka w górę (Ctrl+k)
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- Strzałka w dół (Ctrl+j)
					["<C-Space>"] = cmp.mapping.complete(), -- Ręczne wywołanie okienka
					["<C-e>"] = cmp.mapping.abort(), -- Zamknięcie okienka
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter zatwierdza wybór

					-- Użycie Tabulatora do przechodzenia po liście
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
						elseif luasnip.expand_or_jumpable(-1) then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- Skąd nvim-cmp ma brać podpowiedzi? (Kolejność ma znaczenie - LSP najwyżej)
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- Magia z basedpyright (metody Polars, typy)
					{ name = "luasnip" }, -- Snippety
					{ name = "path" }, -- Ścieżki do plików
				}, {
					{ name = "buffer" }, -- Jeśli nic nie znajdzie, podpowiada słowa z pliku
				}),
				-- DODATEK: Informacja skąd pochodzi podpowiedź (LSP/Plik/Ścieżka)
				formatting = {
					format = function(entry, vim_item)
						local source_names = {
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							buffer = "[File]",
							path = "[Path]",
						}
						vim_item.menu = source_names[entry.source.name] or string.format("[%s]", entry.source.name)
						return vim_item
					end,
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(";", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
}
