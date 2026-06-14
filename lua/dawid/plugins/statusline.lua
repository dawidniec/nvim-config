-- Pasek statusu na dole ekranu: lualine.
-- Pokazuje m.in. tryb (NORMAL/INSERT), gałąź gita, nazwę pliku, pozycję kursora
-- i liczbę błędów/ostrzeżeń z LSP.
require("lualine").setup({
  options = {
    theme = "tokyonight",    -- spójny kolorystycznie z motywem edytora
    section_separators = "", -- bez ozdobnych "strzałek" — czysto i bez wymagań fontowych
    component_separators = "|",
  },
})
