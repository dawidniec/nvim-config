-- Przeglądarka plików: oil.nvim.
--
-- Pomysł oil jest inny niż w klasycznym drzewku: katalog otwierasz jak ZWYKŁY
-- bufor tekstowy. Zmiana nazwy pliku = edycja linii, usunięcie = skasowanie linii,
-- nowy plik = dopisanie linii. Zapis bufora (:w) wykonuje te zmiany na dysku.
-- Dla kogoś, kto zna już ruchy Vima, to bardzo naturalne.

require("oil").setup({
  view_options = {
    show_hidden = true, -- pokazuj pliki ukryte (te zaczynające się od kropki)
  },
})

-- "-" otwiera katalog bieżącego pliku (to domyślny, "wbudowany" w oil skrót).
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Otwórz katalog (oil)" })

-- Dodatkowy alias pod leaderem, jeśli wolisz:
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Eksplorator plików (oil)" })
