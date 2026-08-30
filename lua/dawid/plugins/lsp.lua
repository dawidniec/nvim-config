-- LSP = Language Server Protocol. Serwer językowy podpowiada uzupełnienia,
-- pokazuje definicje, dokumentację i błędy (diagnostykę). W Neovim 0.11+
-- włączamy serwery natywnie, funkcją vim.lsp.enable().

-- 1) mason: instaluje serwery jednym poleceniem, tak samo na macOS i Ubuntu.
--    Graficzne okno instalatora otworzysz komendą :Mason
require("mason").setup()

-- 2) mason-lspconfig: pilnuje, żeby potrzebne serwery były zainstalowane.
--    Wyłączamy automatyczne uruchamianie serwerów, żeby lista aktywnych LSP była
--    jawna i kontrolowana w jednym miejscu przez vim.lsp.enable() poniżej.
require("mason-lspconfig").setup({
  ensure_installed = {
    "basedpyright", -- Python: typy, podpowiedzi, nawigacja po kodzie
    "ruff",         -- Python: bardzo szybki linter + formater
    "bashls",       -- Bash: bash-language-server
    "rust_analyzer", -- Rust: analiza kodu, podpowiedzi, nawigacja i diagnostyka
  },
  automatic_enable = false,
})

-- 3) Włączamy serwery. Ich gotowe konfiguracje dostarcza nvim-lspconfig
--    (są już na "runtimepath"), więc wystarczy podać nazwy.
vim.lsp.enable({ "basedpyright", "ruff", "bashls", "rust_analyzer" })

-- 4) Skróty LSP ustawiamy dopiero w chwili, gdy serwer "podłączy się" do bufora
--    (zdarzenie LspAttach). Dzięki temu działają tylko tam, gdzie jest serwer.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local function nmap(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
    end
    nmap("gd", vim.lsp.buf.definition, "Idź do definicji")
    nmap("K", vim.lsp.buf.hover, "Pokaż dokumentację pod kursorem")
    nmap("<leader>rn", vim.lsp.buf.rename, "Zmień nazwę symbolu (wszędzie)")
    nmap("<leader>ca", vim.lsp.buf.code_action, "Akcje kodu (np. autopoprawka)")
    nmap("<leader>d", vim.diagnostic.open_float, "Pokaż błąd/ostrzeżenie w linii")
  end,
})

-- Diagnostyka (błędy/ostrzeżenia LSP).
-- Domyślnie pokazujemy skrócony komunikat na końcu linii (virtual_text) — tak jak
-- na początku. Pełną, zawiniętą treść zobaczysz NA ŻĄDANIE: naciśnij <leader>d,
-- by otworzyć okienko (float) z całym opisem dla linii pod kursorem.
vim.diagnostic.config({ virtual_text = true })
