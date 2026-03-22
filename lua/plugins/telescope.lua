return {
	{
		"nvim-telescope/telescope.nvim",

		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- Kompiluje silnik w C podczas instalacji wtyczki
				build = "make",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			-- 1. NAJPIERW SETUP: Główna konfiguracja zgodnie z dokumentacją
			telescope.setup({
				defaults = {
					prompt_prefix = "   ",
					selection_caret = " ",
					path_display = { "truncate" }, -- Inteligentnie skraca długie ścieżki

					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<Esc>"] = actions.close,
						},
					},
				},
			})

			-- 2. POTEM ROZSZERZENIA: Ładujemy FZF PO wykonaniu setup()
			-- Używamy pcall (protected call) - dzięki temu jeśli na innym komputerze
			-- zabraknie kompilatora 'make', Neovim się nie zawiesi, tylko cicho pominie FZF.
			pcall(telescope.load_extension, "fzf")

			-- 3. SKRÓTY KLAWISZOWE: Podłączamy wbudowane funkcje (builtins)
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set

			map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Znajdź pliki" })
			map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Szukaj w tekście" })
			map("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Otwarte pliki" })
			map("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope: Błędy w projekcie" })
			map("n", "<leader>fc", builtin.grep_string, { desc = "Telescope: Szukaj słowa pod kursorem" })
			map("n", "<leader>fr", builtin.resume, { desc = "Telescope: Wznów" })
		end,
	},
}
