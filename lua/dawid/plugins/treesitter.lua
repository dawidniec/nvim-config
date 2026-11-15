-- Kolorowanie składni przez treesitter (gałąź `main`, nowe API od 2026 r.).
--
-- Uwaga, jeśli widziałeś starsze poradniki: NIE używamy już
--   require("nvim-treesitter.configs").setup{ ensure_installed = ..., highlight = ... }
-- Na gałęzi `main` parsery instalujemy ręcznie, a podświetlanie włączamy sami.
-- To trochę więcej pisania, ale jest jawnie i przewidywalnie.

local ts = require("nvim-treesitter")

-- Nextflow nie jest jeszcze w rejestrze nvim-treesitter. install() i :TSUpdate
-- przeładowują rejestr, dlatego dodajemy parser w hooku User TSUpdate.
-- Parser i zapytania pochodzą z tego samego, przypiętego commita.
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("dawid_nextflow_parser", { clear = true }),
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").nextflow = {
      install_info = {
        url = "https://github.com/nextflow-io/tree-sitter-nextflow",
        revision = "b27430d88bf201d559dc1be426988388da8e5a54",
        queries = "queries",
      },
      requires = { "bash" }, -- podświetlanie poleceń wewnątrz skryptów procesów
    }
  end,
})

-- Języki, dla których chcemy parsery. install() pobierze brakujące w tle
-- (przy pierwszym uruchomieniu chwilę to trwa — patrz README).
ts.install({
  "python", "bash", "rust", "lua", "vim", "vimdoc",
  "markdown", "markdown_inline", "json", "yaml", "toml",
  "gitcommit", "gitignore", "diff",
  "nextflow",
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
