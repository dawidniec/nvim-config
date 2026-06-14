-- Autouzupełnianie: blink.cmp.

require("blink.cmp").setup({
  -- Wybór podpowiedzi: Tab/Shift-Tab chodzą po liście, Enter zatwierdza zaznaczoną.
  --   <Tab>     = następna podpowiedź (a gdy menu zamknięte, skok w snippetcie)
  --   <S-Tab>   = poprzednia podpowiedź
  --   <CR>      = zatwierdź zaznaczoną podpowiedź (gdy nic nie wybrano — zwykły Enter)
  --   <C-space> = pokaż / przełącz menu,   <C-e> = zamknij menu
  -- Lista komend wykonuje się po kolei, aż któraś "zadziała"; "fallback" = zwykłe
  -- działanie klawisza (np. wstawienie tabulatora / nowej linii).
  keymap = {
    preset = "enter",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },

  appearance = {
    nerd_font_variant = "mono", -- ikonki z Nerd Font w menu podpowiedzi
  },

  completion = {
    -- Nic nie jest zaznaczone z góry — pozycję wybierasz sam Tab-em. Dzięki temu
    -- Enter zatwierdza tylko to, co świadomie zaznaczyłeś (inaczej robi nową linię).
    list = { selection = { preselect = false } },
    -- Po krótkiej chwili pokaż okienko z dokumentacją zaznaczonej podpowiedzi.
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
  },

  -- Źródła podpowiedzi: serwer LSP, ścieżki plików, snippety, słowa z otwartego bufora.
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  -- Użyj szybkiego dopasowania w Ruście (gotowe binarium z wydania 1.x).
  -- Gdyby binarium się nie pobrało, blink przełączy się na wolniejszą wersję w Lua
  -- i tylko wyświetli ostrzeżenie — nie zepsuje to działania edytora.
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
