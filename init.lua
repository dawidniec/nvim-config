-- ~/.config/nvim/init.lua
-- Punkt wejścia. Neovim czyta ten plik przy każdym starcie.
-- Trzymamy tu tylko KOLEJNOŚĆ wczytywania — szczegóły są w katalogu lua/dawid/.

-- Przyspiesza ładowanie modułów Lua (wbudowany cache). Najlepiej jako pierwsza linia.
vim.loader.enable()

-- "Leader" to klawisz-prefiks do Twoich własnych skrótów (u nas: spacja).
-- Ustawiamy GO PRZED wczytaniem skrótów i pluginów — inaczej część mapowań
-- zapamięta starą wartość leadera. To częsta pułapka.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("dawid.options") -- ustawienia edytora (numery linii, wcięcia itd.)
require("dawid.keymaps") -- skróty niezależne od pluginów
require("dawid.plugins") -- instalacja (vim.pack) + konfiguracja wszystkich pluginów
