-- Wsparcie dla Nextflow.
--
-- Wsparcie składa się z trzech kawałków:
--   1) rozpoznanie plików .nf jako typu "nextflow",
--   2) kolorowanie składni (dedykowany parser tree-sitter-nextflow),
--   3) serwer językowy (podpowiedzi, definicje, diagnostyka).

-- 1) Rozpoznawanie plików. Neovim domyślnie nie wie, czym jest .nf — mówimy mu.
vim.filetype.add({
  extension = { nf = "nextflow" },
  filename = { ["nextflow.config"] = "nextflow" },
})

-- 2) Typ pliku i parser mają tę samą nazwę: nextflow.
--    Rejestrację i instalację parsera oraz zapytań obsługuje plugins/treesitter.lua.

-- 3) Oficjalny serwer językowy Nextflow (od twórców Nextflow).
--    To plik .jar uruchamiany przez Javę — WYMAGA Javy 17+ oraz pobrania pliku .jar
--    (instrukcja w README). Ścieżkę poniżej dostosuj, jeśli zapiszesz .jar gdzie indziej.
local jar = vim.fn.expand("~/.local/share/nextflow-ls/language-server-all.jar")

if vim.fn.filereadable(jar) == 1 then
  -- Definiujemy konfigurację serwera ręcznie (jawnie, niezależnie od lspconfig).
  vim.lsp.config("nextflow_ls", {
    cmd = { "java", "-jar", jar },
    filetypes = { "nextflow" },
    root_markers = { "nextflow.config", ".git" }, -- katalog projektu rozpoznajemy po tych plikach
    settings = {
      nextflow = {
        files = { exclude = { ".git", ".nf-test", "work" } }, -- pomiń katalogi robocze
      },
    },
    -- Serwer Nextflow (pisany głównie pod VS Code) wysyła "semantic tokens",
    -- które potrafią wskazywać linię spoza bufora — Neovim zgłasza wtedy błąd
    -- "Invalid 'line': out of range". Wyłączamy semantic tokens TYLKO dla tego
    -- serwera, jeszcze zanim wystartują (on_init działa zaraz po inicjalizacji,
    -- przed podłączeniem do bufora). Kolorowanie i tak robi treesitter (nextflow),
    -- a podpowiedzi, definicje i diagnostyka działają normalnie.
    on_init = function(client)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })
  vim.lsp.enable("nextflow_ls")
end
-- Jeśli .jar jeszcze nie istnieje, po prostu pomijamy LSP (kolorowanie i tak działa).
