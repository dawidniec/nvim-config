-- Wyszukiwarka: telescope (tzw. "fuzzy finder" — szuka mimo literówek).
-- Szukanie w treści plików (live_grep) wymaga programu ripgrep (`rg`) — patrz README.

require("telescope").setup({})

local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader>ff", builtin.find_files, { desc = "Znajdź pliki po nazwie" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Szukaj tekstu w plikach (grep)" })
map("n", "<leader>fb", builtin.buffers, { desc = "Przełącz między otwartymi buforami" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Przeszukaj pomoc Neovima" })
