-- Skróty NIEZALEŻNE od pluginów.
-- Skróty należące do konkretnych pluginów są przy ich konfiguracji
-- (np. mapowania gita w plugins/git.lua), żeby wszystko było w jednym miejscu.

local map = vim.keymap.set

-- Esc czyści podświetlenie po wyszukiwaniu (set hlsearch zostawia je włączone)
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Szybki zapis / zamknięcie
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Zapisz plik" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Zamknij okno" })

-- Skakanie między oknami: Ctrl + h/j/k/l (zamiast Ctrl-w h itd.)
map("n", "<C-h>", "<C-w>h", { desc = "Okno w lewo" })
map("n", "<C-j>", "<C-w>j", { desc = "Okno w dół" })
map("n", "<C-k>", "<C-w>k", { desc = "Okno w górę" })
map("n", "<C-l>", "<C-w>l", { desc = "Okno w prawo" })

-- Przesuwanie zaznaczonych linii w trybie wizualnym (J w dół, K w górę)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Przesuń zaznaczenie w dół" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Przesuń zaznaczenie w górę" })
