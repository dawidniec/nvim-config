-- Ustawienia edytora.
-- `vim.opt.X = Y` to lua-owy odpowiednik komendy `:set X=Y`.

local opt = vim.opt

-- Numery linii
opt.number = true         -- numer bieżącej linii
opt.relativenumber = true -- pozostałe linie liczone względem kursora (wygodne do ruchu, np. 5j)

-- Wcięcia (Python lubi 4 spacje)
opt.expandtab = true -- klawisz Tab wstawia spacje, a nie znak tabulacji
opt.shiftwidth = 4   -- szerokość jednego poziomu wcięcia
opt.tabstop = 4      -- ile spacji "udaje" jeden Tab
opt.smartindent = true -- automatyczne wcięcie po wejściu w nowy blok

-- Pokaż tylko tabulatory i spacje na końcu linii (zwykłe spacje pozostają niewidoczne).
opt.list = true
opt.listchars = {
    tab = "→ ",
    trail = "·",
}

-- Wyszukiwanie
opt.ignorecase = true -- ignoruj wielkość liter...
opt.smartcase = true  -- ...chyba że w zapytaniu pojawi się wielka litera
opt.incsearch = true  -- podświetlaj dopasowanie już w trakcie pisania
opt.hlsearch = true   -- podświetl wszystkie trafienia (czyścimy je skrótem Esc)

-- Wygląd / wygoda
opt.termguicolors = true -- pełna paleta kolorów (24-bit) — wymagana przez tokyonight
opt.signcolumn = "yes"   -- stała kolumna na znaki (git, błędy) — dzięki temu tekst nie "skacze"
opt.cursorline = true    -- podświetl linię, w której jest kursor
opt.wrap = false         -- nie zawijaj długich linii
opt.scrolloff = 8        -- trzymaj min. 8 linii zapasu nad/pod kursorem przy przewijaniu
opt.splitright = true    -- nowe pionowe okno otwieraj po prawej
opt.splitbelow = true    -- nowe poziome okno otwieraj na dole

-- Ramka wokół okienek pływających (hover, diagnostyka, podpowiedzi). Bez niej float
-- zlewa się z ciemnym tłem tokyonight; ramka (kolor FloatBorder) wyraźnie go odcina.
-- Działa globalnie dla wszystkich floatów (Neovim 0.11+).
opt.winborder = "rounded"

-- Pliki / historia
opt.swapfile = false -- bez plików .swp
opt.undofile = true  -- zachowuj historię cofania (undo) między sesjami

-- Wspólny schowek z systemem (kopiuj/wklejaj między Neovim a resztą systemu).
-- Na Linuksie wymaga narzędzia: wl-clipboard (Wayland) lub xclip (X11) — patrz README.
opt.clipboard = "unnamedplus"

-- Szybsze reakcje pluginów reagujących na bezczynność (np. gitsigns, diagnostyka)
opt.updatetime = 250

-- Mignięcie podświetlenia po skopiowaniu tekstu (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
