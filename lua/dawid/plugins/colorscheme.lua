-- Motyw tokyonight.
-- Dostępne warianty stylu: "night" (ciemny), "storm", "moon", "day" (jasny).
require("tokyonight").setup({
  style = "night",
})

-- Włącz motyw. Robimy to tutaj, zaraz po vim.pack.add, żeby kolory pojawiły się
-- od razu przy starcie (a nie po chwili "migania" domyślnym motywem).
vim.cmd.colorscheme("tokyonight")
