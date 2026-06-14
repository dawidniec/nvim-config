# Konfiguracja Neovim (0.12+) — Python & Bash

Lekka, modularna konfiguracja dla hobbysty. Oparta na **wbudowanym** menedżerze
wtyczek `vim.pack` (Neovim 0.12+), z minimalną liczbą sprawdzonych, aktywnie
rozwijanych pluginów.

## Co jest w zestawie

| Funkcja | Rozwiązanie |
| --- | --- |
| Menedżer wtyczek | `vim.pack` (wbudowany w Neovim 0.12) |
| Motyw | tokyonight |
| Kolorowanie składni | nvim-treesitter (gałąź `main`) |
| Autouzupełnianie | blink.cmp |
| LSP (serwery językowe) | nvim-lspconfig + mason (basedpyright, ruff, bashls) |
| Git | gitsigns (znaczniki) + lazygit (TUI) |
| Przeglądarka plików | oil.nvim |
| Pasek statusu | lualine |
| Wyszukiwarka | telescope |
| Podpowiedzi skrótów | which-key |
| Domykanie nawiasów | nvim-autopairs |
| Nextflow | parser groovy (kolory) + oficjalny serwer językowy nextflow_ls |

## Struktura plików

```
~/.config/nvim/
├── init.lua                 # punkt wejścia: kolejność wczytywania
├── nvim-pack-lock.json      # (powstaje sam po 1. starcie — commituj go!)
└── lua/dawid/
    ├── options.lua          # ustawienia edytora
    ├── keymaps.lua          # skróty niezależne od pluginów
    └── plugins/
        ├── init.lua         # JEDNA lista vim.pack.add(...) + kolejność konfiguracji
        ├── colorscheme.lua
        ├── treesitter.lua
        ├── completion.lua
        ├── lsp.lua
        ├── git.lua
        ├── files.lua
        ├── statusline.lua
        ├── finder.lua
        ├── which-key.lua
        ├── autopairs.lua
        └── nextflow.lua
```

## Zanim zaczniesz — co zainstalować w systemie

Neovim w wersji **0.12 lub nowszej** (sprawdź: `nvim --version`). Reszta to programy,
których wymagają poszczególne pluginy.

### macOS (Homebrew)

```bash
brew install neovim ripgrep lazygit
brew install openjdk@17                              # Java dla serwera językowego Nextflow
xcode-select --install                               # kompilator C (dla parserów treesittera)
brew install --cask font-jetbrains-mono-nerd-font    # font z ikonami
```

### Ubuntu

```bash
sudo apt update
sudo apt install neovim build-essential ripgrep git curl wl-clipboard openjdk-17-jre
# (jeśli używasz X11 zamiast Wayland, zamiast wl-clipboard daj: sudo apt install xclip)
```

`lazygit` często nie ma w domyślnych repozytoriach Ubuntu — najpewniej pobrać oficjalną binarkę:

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit lazygit.tar.gz
```

Font z ikonami (Nerd Font) na Ubuntu pobierzesz z https://www.nerdfonts.com — rozpakuj
do `~/.local/share/fonts`, uruchom `fc-cache -f`, a potem **ustaw ten font w swoim terminalu**.
Bez Nerd Font wszystko działa, ale ikonki będą wyglądać jak puste kwadraciki.

> **Uwaga o `nvim --version`:** jeśli Twoja dystrybucja ma starszego Neovima niż 0.12,
> użyj nowszej paczki (np. na Ubuntu: `sudo snap install nvim --classic`, albo wydanie
> AppImage z https://github.com/neovim/neovim/releases).

## Instalacja konfiguracji

Jeśli masz już jakiś config Neovima — najpierw zrób kopię, żeby nic nie stracić:

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.backup 2>/dev/null   # stare pluginy/dane
```

Skopiuj zawartość tego katalogu do `~/.config/nvim`, a następnie uruchom `nvim`.
Przy pierwszym starcie `vim.pack` zapyta, które pluginy pobrać — naciśnij **`a`**
(akceptuj wszystkie). Potem:

1. Poczekaj, aż treesitter dociągnie parsery (to chwilę trwa — w tle).
2. Wpisz `:Mason` i sprawdź, czy serwery (basedpyright, ruff, bash-language-server)
   się instalują.
3. **Zrestartuj Neovima** — kolorowanie składni i podpowiedzi będą już aktywne.

Diagnostyka, gdyby coś nie grało: `:checkhealth` (ogólnie) oraz `:checkhealth vim.pack`
(dla menedżera wtyczek).

## Trzymanie configu na GitHubie

Po pierwszym uruchomieniu (gdy istnieje już `nvim-pack-lock.json`):

```bash
cd ~/.config/nvim
git init
git add .
git commit -m "Moja konfiguracja Neovim"
# utwórz puste repo na GitHubie, potem:
git remote add origin git@github.com:TWOJ_LOGIN/nvim.git
git branch -M main
git push -u origin main
```

Na drugim komputerze (po zainstalowaniu programów z sekcji wyżej):

```bash
git clone git@github.com:TWOJ_LOGIN/nvim.git ~/.config/nvim
nvim   # vim.pack odtworzy pluginy z nvim-pack-lock.json
```

Plik `nvim-pack-lock.json` **commituj razem z configiem** — to on gwarantuje, że na
obu maszynach masz dokładnie te same wersje pluginów.

## Nextflow

Kolorowanie plików `.nf` działa od razu (przez parser Groovy — Nextflow to dialekt Groovy).
Żeby dostać też podpowiedzi, definicje i diagnostykę, doinstaluj oficjalny **serwer językowy
Nextflow**. To plik `.jar` uruchamiany Javą (stąd `openjdk-17` w wymaganiach):

```bash
mkdir -p ~/.local/share/nextflow-ls
# Pobierz najnowszy plik "language-server-all.jar" ze strony wydań:
#   https://github.com/nextflow-io/language-server/releases
# i zapisz go pod tą nazwą:
#   ~/.local/share/nextflow-ls/language-server-all.jar
```

Config sam wykryje ten plik przy starcie: jeśli `.jar` jest na miejscu, serwer się włączy;
jeśli go nie ma, Neovim po prostu pominie LSP (kolorowanie i tak działa). Ścieżkę można
zmienić w `lua/dawid/plugins/nextflow.lua`. Sprawdzić, czy serwer wstał: otwórz plik `.nf`
i wpisz `:checkhealth lsp` albo `:lua =vim.lsp.get_clients()`.

## Skróty (leader = spacja)

| Skrót | Działanie |
| --- | --- |
| `<space>w` / `<space>q` | zapisz / zamknij okno |
| `<Esc>` | wyczyść podświetlenie wyszukiwania |
| `Ctrl-h/j/k/l` | skok między oknami |
| `-` lub `<space>e` | przeglądarka plików (oil) |
| `<space>ff` | znajdź plik po nazwie |
| `<space>fg` | szukaj tekstu w plikach |
| `<space>fb` | przełącz bufor |
| `<space>fh` | przeszukaj pomoc |
| `<space>gg` | otwórz lazygit |
| `]c` / `[c` | następna / poprzednia zmiana gita |
| `<space>hp/hs/hr` | podgląd / dodaj (stage) / cofnij zmianę |
| `gd` | idź do definicji (LSP) |
| `K` | dokumentacja pod kursorem (LSP) |
| `<space>rn` | zmień nazwę symbolu (LSP) |
| `<space>ca` | akcje kodu (LSP) |
| `<space>d` | pokaż błąd/ostrzeżenie w linii |
| `<C-y>` (w menu) | zaakceptuj podpowiedź |

## Codzienne zarządzanie pluginami

- **Aktualizacja wszystkich:** `:PackUpdate` (pokaże podgląd zmian — zapisz kartę, by potwierdzić).
- **Dodanie pluginu:** dopisz wpis w `lua/dawid/plugins/init.lua` w `vim.pack.add({...})`,
  dodaj jego konfigurację i zrestartuj Neovima.
- **Usunięcie pluginu:** najpierw skasuj go z configu, potem `:lua vim.pack.del({ "nazwa-pluginu" })`.

## Drobne uwagi

- **basedpyright + ruff** trochę się pokrywają (oba potrafią pokazać informacje pod
  kursorem). Na start to nie przeszkadza; gdyby diagnostyka się dublowała, można
  wyłączyć linter w jednym z nich — daj znać, dopasujemy.
- Treesitter na gałęzi `main` przy pierwszym pliku danego typu może chwilę nie
  kolorować, dopóki parser się nie pobierze. To normalne — po restarcie działa od razu.
- **Treesitter jest zarchiwizowany** (od 3.04.2026, tylko do odczytu). Gałąź `main`
  działa stabilnie na 0.12, ale nie dostaje już aktualizacji. Gdy wyklaruje się
  utrzymywany następca (lub rdzeń Neovima przejmie zarządzanie parserami), warto
  rozważyć przesiadkę. Na razie to świadomy, pragmatyczny wybór.

## Łatwe dodatki na później (opcjonalnie)

- `stevearc/conform.nvim` — formatowanie przy zapisie (np. ruff dla Pythona).

Jeśli zechcesz, dopiszę gotowy moduł w tym samym stylu.

