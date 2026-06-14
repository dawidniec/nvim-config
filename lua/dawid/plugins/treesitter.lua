-- Kolorowanie składni przez treesitter (gałąź `main`, nowe API od 2026 r.).
--
-- Uwaga, jeśli widziałeś starsze poradniki: NIE używamy już
--   require("nvim-treesitter.configs").setup{ ensure_installed = ..., highlight = ... }
-- Na gałęzi `main` parsery instalujemy ręcznie, a podświetlanie włączamy sami.
-- To trochę więcej pisania, ale jest jawnie i przewidywalnie.

local ts = require("nvim-treesitter")

-- Języki, dla których chcemy parsery. install() pobierze brakujące w tle
-- (przy pierwszym uruchomieniu chwilę to trwa — patrz README).
ts.install({
  "python", "bash", "lua", "vim", "vimdoc",
  "markdown", "markdown_inline", "json", "yaml", "toml",
  "gitcommit", "gitignore", "diff",
  "groovy", -- używany do kolorowania plików Nextflow (.nf) — patrz plugins/nextflow.lua
})

-- Włączamy kolorowanie po wejściu w plik. vim.treesitter.start() uruchamia
-- podświetlanie dla bieżącego bufora i sam dobiera język po typie pliku.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    -- pcall = "spróbuj, ale nie wysypuj się przy błędzie". Jeśli parser dla danego
    -- typu pliku nie jest jeszcze zainstalowany, po prostu pomijamy (zamiast błędu).
    pcall(vim.treesitter.start, args.buf)
  end,
})
