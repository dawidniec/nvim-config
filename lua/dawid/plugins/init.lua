-- Centralne miejsce instalacji pluginów przez WBUDOWANY menedżer vim.pack (Neovim 0.12+).
--
-- Najważniejsza rzecz do zrozumienia: vim.pack.add() to ZWYKŁA FUNKCJA. Wywołana,
-- pobiera brakujące pluginy z GitHuba (git clone) i od razu je ładuje. Nic nie dzieje
-- się "magicznie w tle" — kolejność wykonywania kodu to kolejność w pliku.
--
-- Reguła: zależności (np. plenary, ikony) MUSZĄ być na liście przed tym, co ich używa.

-- HOOK instalacyjny treesittera — MUSI powstać PRZED vim.pack.add().
-- Po każdej aktualizacji pluginu odświeżamy parsery (:TSUpdate). Inaczej wersja
-- parserów może rozjechać się z wersją pluginu i kolorowanie zacznie się psuć.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- Motyw
  { src = "https://github.com/folke/tokyonight.nvim" },

  -- Ikony używane przez pasek statusu, oil i telescope (wymaga Nerd Font — patrz README)
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- Kolorowanie składni. Gałąź `main` to aktualne, przepisane API przeznaczone
  -- dla Neovima 0.12+, dlatego przypinamy się jawnie do "main".
  -- Po aktualizacji pluginu parsery są automatycznie odświeżane przez hook PackChanged powyżej.
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

  -- Autouzupełnianie. blink.cmp jest napisany w Ruście; przypięcie do wydań 1.x
  -- sprawia, że Neovim pobierze GOTOWE binarium zamiast kompilować je u Ciebie.
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
  { src = "https://github.com/rafamadriz/friendly-snippets" }, -- zestaw gotowych snippetów

  -- LSP (serwery językowe: podpowiedzi, definicje, diagnostyka)
  { src = "https://github.com/neovim/nvim-lspconfig" },          -- gotowe konfiguracje serwerów
  { src = "https://github.com/mason-org/mason.nvim" },           -- instalator serwerów (macOS + Ubuntu)
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" }, -- spina mason z lspconfig

  -- Git
  { src = "https://github.com/lewis6991/gitsigns.nvim" }, -- znaczniki zmian w kolumnie
  { src = "https://github.com/kdheepak/lazygit.nvim" },   -- pełne, wizualne TUI gita

  -- Przeglądarka plików (katalog edytujesz jak zwykły tekst)
  { src = "https://github.com/stevearc/oil.nvim" },

  -- Pasek statusu
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  -- Wyszukiwarka (pliki, treść, bufory). plenary to jej biblioteka pomocnicza.
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },

  -- Wygoda / drobne usprawnienia
  { src = "https://github.com/folke/which-key.nvim" },    -- podpowiada skróty po naciśnięciu leadera
  { src = "https://github.com/windwp/nvim-autopairs" },   -- automatyczne domykanie nawiasów/cudzysłowów
})

-- Konfiguracja poszczególnych pluginów.
-- Kolejność ma znaczenie tam, gdzie jeden plugin korzysta z drugiego.
require("dawid.plugins.colorscheme") -- motyw najpierw (mniej "mrugania" przy starcie)
require("dawid.plugins.treesitter")
require("dawid.plugins.completion")
require("dawid.plugins.lsp")
require("dawid.plugins.git")
require("dawid.plugins.files")
require("dawid.plugins.statusline")
require("dawid.plugins.finder")
require("dawid.plugins.which-key")
require("dawid.plugins.autopairs")
require("dawid.plugins.nextflow")

-- Wygodna komenda do aktualizacji wszystkich pluginów: wpisz :PackUpdate
-- (vim.pack pokaże osobną kartę z podglądem zmian — zapisz ją, by potwierdzić).
vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Zaktualizuj wszystkie pluginy (vim.pack)" })
