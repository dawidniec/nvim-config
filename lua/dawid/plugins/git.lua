-- Wsparcie dla gita.

-- gitsigns: pokazuje zmiany (dodane/zmienione/usunięte linie) w kolumnie obok numerów.
require("gitsigns").setup({
  -- on_attach uruchamia się dla każdego pliku w repo gita — tu ustawiamy skróty.
  on_attach = function(buf)
    local gs = require("gitsigns")
    local function nmap(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = buf, desc = "Git: " .. desc })
    end
    nmap("]c", function() gs.nav_hunk("next") end, "Następna zmiana")
    nmap("[c", function() gs.nav_hunk("prev") end, "Poprzednia zmiana")
    nmap("<leader>hp", gs.preview_hunk, "Podgląd zmiany w okienku")
    nmap("<leader>hs", gs.stage_hunk, "Dodaj zmianę do commita (stage)")
    nmap("<leader>hr", gs.reset_hunk, "Cofnij zmianę (reset)")
  end,
})

-- lazygit: pełne, wizualne TUI gita w oknie Neovima (commity, gałęzie, push/pull).
-- Wymaga zainstalowanej w systemie binarki `lazygit` — patrz README.
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Otwórz lazygit" })
