return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		ts.setup({
			-- 1. Deklaratywna lista parserów
			ensure_installed = {
				"lua",
				"python",
				"json",
				"yaml",
				"bash",
				"toml",
				"javascript",
				"markdown",
				"markdown_inline",
			},

			-- 2. Automatyczna instalacja parserów przy otwarciu nowego typu pliku
			auto_install = true,

			-- 3. Synchronizacja instalacji (opcjonalnie, zapobiega blokowaniu przy starcie)
			sync_install = false,

			-- Uwaga: Na gałęzi main klasyczne moduły (highlight, indent) są w fazie
			-- zmian, dlatego Twoje podejście z autocmd jest tu najbezpieczniejsze.
		})

		-- 4. Ulepszony Autocmd do uruchamiania podświetlania i wcięć
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
			callback = function(event)
				local buf = event.buf
				local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)

				-- Sprawdzamy, czy Neovim rozpoznaje język i czy mamy dla niego parser
				if lang and vim.treesitter.language.add(lang) then
					-- Bezpieczne uruchomienie podświetlania
					pcall(vim.treesitter.start, buf, lang)

					-- Ustawienie inteligentnych wcięć (indentation)
					-- Tylko jeśli faktycznie chcesz używać Treesitter do tego celu
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
