local map = vim.keymap.set

-- Szybsze poruszanie się między oknami
map("n", "<C-h>", "<C-w>h", { desc = "Idź do lewego okna" })
map("n", "<C-j>", "<C-w>j", { desc = "Idź do dolnego okna" })
map("n", "<C-k>", "<C-w>k", { desc = "Idź do górnego okna" })
map("n", "<C-l>", "<C-w>l", { desc = "Idź do prawego okna" })

-- Zmiana rozmiaru okien (Ctrl + Strzałki)
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Zwiększ wysokość" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Zmniejsz wysokość" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Zmniejsz szerokość" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Zwiększ szerokość" })

-- Przełączanie między otwartymi plikami (Shift + h/l)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Poprzedni plik" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Następny plik" })

-- Zamknij obecny plik (bufor)
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Zamknij obecny plik" })

-- Przesuwanie zaznaczonego tekstu w górę i w dół (Tryb wizualny)
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Przesuń kod w dół" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Przesuń kod w górę" })

-- Lepsze wcięcia (zostaje zaznaczenie po użyciu > lub <)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Przesuwanie zaznaczonego tekstu w górę i w dół (Tryb wizualny)
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Przesuń kod w dół" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Przesuń kod w górę" })

-- Lepsze wcięcia (zostaje zaznaczenie po użyciu > lub <)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Skakanie między błędami/ostrzeżeniami
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Poprzedni błąd/ostrzeżenie" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Następny błąd/ostrzeżenie" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Pokaż szczegóły błędu (pływające okno)" })

-- Twój skrót do czyszczenia wyszukiwania
map({ "n" }, "<Esc>", "<cmd>noh<cr>", { desc = "Wyczyść podświetlenie szukania" })

-- Szybkie wyjście z trybu Insert za pomocą 'jk'
map("i", "jk", "<Esc>", { desc = "Wyjdź do trybu Normalnego" })
