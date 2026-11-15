# Neovim config — Python, Bash, Rust & Nextflow

Lekka, modularna konfiguracja Neovima 0.12+ oparta na wbudowanym menedżerze
pluginów `vim.pack`. Cel: mało pluginów, czytelny Lua i wygodna konfiguracja do
codziennej pracy bez rozbudowanego frameworka wokół Neovima.

## Co jest w zestawie

| Funkcja | Rozwiązanie |
| --- | --- |
| Pluginy | `vim.pack` + `nvim-pack-lock.json` |
| Motyw | TokyoNight (`moon`) |
| Składnia | nvim-treesitter (`main`) |
| Autouzupełnianie | blink.cmp + friendly-snippets |
| LSP | nvim-lspconfig + mason + mason-lspconfig |
| Python | basedpyright + ruff |
| Bash | bash-language-server |
| Rust | rust-analyzer + Treesitter |
| Nextflow | tree-sitter-nextflow + oficjalny Nextflow Language Server |
| Git | gitsigns + lazygit |
| Pliki | oil.nvim |
| Wyszukiwanie | telescope.nvim |
| Statusline | lualine.nvim |
| Podpowiedzi skrótów | which-key.nvim |
| Domykanie nawiasów | nvim-autopairs |
| Białe znaki | widoczne tabulatory i trailing spaces |

## Szybka instalacja

Wymagany jest **Neovim 0.12 lub nowszy**.

Jeśli masz już konfigurację Neovima, najpierw zrób jej kopię:

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
```

Następnie:

```bash
git clone https://github.com/dawidniec/nvim-config.git ~/.config/nvim
nvim
```

Przy pierwszym uruchomieniu `vim.pack` automatycznie pobierze brakujące pluginy.
Repo zawiera `nvim-pack-lock.json`, więc pluginy zostaną odtworzone w zapisanych
wersjach.

Treesitter zacznie również pobierać brakujące parsery, a Mason zainstaluje
skonfigurowane serwery LSP. Po zakończeniu instalacji warto raz zrestartować
Neovima.

Stan LSP możesz sprawdzić przez:

```vim
:Mason
:checkhealth lsp
```

## Wymagania systemowe

Poza Neovimem konfiguracja korzysta z kilku programów zewnętrznych:

- `git` — pobieranie pluginów i praca z repozytoriami,
- `ripgrep` (`rg`) — `Telescope live_grep`,
- `lazygit` — interfejs Git uruchamiany przez `<space>gg`,
- `curl`, `tar` i kompilator C — wymagane przez nvim-treesitter,
- `tree-sitter-cli >= 0.26.1`,
- Nerd Font — opcjonalny, ale potrzebny do poprawnego wyświetlania ikon,
- Rust toolchain (`rustc`, `cargo`) — jeśli edytujesz Rust,
- Java 17+ — jeśli chcesz używać Nextflow Language Server.

### macOS (Homebrew)

```bash
brew install neovim ripgrep lazygit curl tree-sitter openjdk@21
brew install --cask font-jetbrains-mono-nerd-font
xcode-select --install
```

`openjdk@21` jest keg-only, więc upewnij się, że `java` jest dostępna w `PATH`:

```bash
echo 'export PATH="$(brew --prefix openjdk@21)/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
java --version
```

Rust najprościej zainstalować przez rustup:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Ubuntu

```bash
sudo apt update
sudo apt install neovim build-essential ripgrep git curl tar wl-clipboard openjdk-21-jre
```

Jeśli używasz X11 zamiast Waylanda, zamiast `wl-clipboard` zainstaluj `xclip`.

Pakiet `neovim` w repozytorium Twojej wersji Ubuntu może być starszy niż 0.12.
Sprawdź:

```bash
nvim --version
```

Jeśli jest za stary, zainstaluj aktualne wydanie Neovima z oficjalnych wydań projektu.

Rust:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

`tree-sitter-cli` musi mieć wersję co najmniej 0.26.1. Sprawdź:

```bash
tree-sitter --version
```

Nie używaj starej wersji instalowanej z npm tylko dlatego, że występuje w starszych
poradnikach Treesittera.

`lazygit` nie zawsze jest dostępny w domyślnych repozytoriach Ubuntu. Jeśli go nie
ma, zainstaluj oficjalną binarkę zgodnie z instrukcją projektu lazygit.

## Najważniejsze skróty

Leader to **spacja**.

| Skrót | Działanie |
| --- | --- |
| `<space>w` | zapisz plik |
| `<space>q` | zamknij okno |
| `<space>Q` | zamknij okno bez zapisywania |
| `<Esc>` | wyczyść podświetlenie wyszukiwania |
| `Ctrl-h/j/k/l` | przejdź do okna w lewo/dół/górę/prawo |
| `-` lub `<space>e` | otwórz oil.nvim |
| `<space>ff` | znajdź plik po nazwie |
| `<space>fg` | szukaj tekstu w plikach |
| `<space>fb` | otwórz wyszukiwalną listę buforów |
| `<space>fh` | przeszukaj pomoc Neovima |
| `<space>gg` | otwórz lazygit |
| `]c` / `[c` | następna / poprzednia zmiana Git |
| `<space>hp` | podgląd zmiany Git |
| `<space>hs` | stage bieżącej zmiany |
| `<space>hr` | cofnij bieżącą zmianę |
| `gd` | idź do definicji (LSP) |
| `K` | dokumentacja pod kursorem (LSP) |
| `<space>rn` | zmień nazwę symbolu (LSP) |
| `<space>ca` | code action (LSP) |
| `<space>d` | diagnostyka bieżącej linii |
| `<Enter>` w menu | zaakceptuj zaznaczoną podpowiedź |
| `<Tab>` / `<S-Tab>` w menu | następna / poprzednia podpowiedź |

## Bufory, okna i splity

W Neovimie warto rozróżnić trzy pojęcia:

- **buffer** — zawartość pliku lub inny edytowany tekst,
- **window** — widok pokazujący bufor,
- **tab page** — układ jednego lub kilku okien.

Dlatego `:vs` (`:vsplit`) tworzy **nowe okno**, a nie nowy bufor. Początkowo oba
okna mogą pokazywać ten sam bufor.

Najwygodniejsze sposoby pracy z buforami w tej konfiguracji:

```text
<space>fb   lista otwartych buforów w Telescope
Ctrl-^      przełącz na poprzednio używany bufor (wbudowany Neovim)
:bn         następny bufor
:bp         poprzedni bufor
```

Do przechodzenia między splitami używaj `Ctrl-h/j/k/l`.

## Białe znaki

Konfiguracja pokazuje tylko znaki, które zwykle warto zauważyć podczas edycji:

- tabulator jako `→`,
- spacje na końcu linii jako `·`.

Zwykłe spacje wewnątrz tekstu pozostają niewidoczne.

## Rust

Wsparcie dla Rusta korzysta z istniejącego stosu pluginów, bez dodatkowego
`rustaceanvim`:

- Treesitter — składnia,
- `rust-analyzer` — diagnostyka, definicje, rename i code actions,
- blink.cmp — podpowiedzi LSP i snippety.

Toolchain Rust musi być dostępny w systemie:

```bash
rustc --version
cargo --version
```

Szybki test:

```bash
cargo new hello-rust
cd hello-rust
nvim src/main.rs
```

Dla pliku `.rs` polecenie:

```vim
:lua =vim.lsp.get_clients()
```

powinno pokazać klienta `rust_analyzer`.

## Nextflow

Pliki `.nf` i `nextflow.config` są rozpoznawane jako `nextflow`. Kolorowanie
zapewnia dedykowany [tree-sitter-nextflow](https://github.com/nextflow-io/tree-sitter-nextflow).
Parser oraz zapytania podświetlania są pobierane razem z commita
`b27430d88bf201d559dc1be426988388da8e5a54`, przypiętego w
`lua/dawid/plugins/treesitter.lua`. Zapytania obejmują również osadzony Bash;
jego parser jest instalowany jako zależność. Nie trzeba instalować pakietu Python.

Parser jest rejestrowany przez hook `User TSUpdate`, więc działa także po
odświeżeniu rejestru przez `:TSUpdate` i `:PackUpdate`.
Po pobraniu tej zmiany uruchom Neovima, poczekaj na instalację parsera i zrestartuj
edytor, aby załadować nowe zapytania podświetlania.

Diagnostyka kolorowania w otwartym pliku Nextflow:

```vim
:set filetype?
:InspectTree
:Inspect
```

Typ pliku powinien być `nextflow`, a `:InspectTree` powinno pokazywać drzewo
parsera Nextflow. W treści skryptu procesu `:Inspect` pozwala sprawdzić
podświetlanie Bash. W razie problemów z instalacją użyj `:TSInstall nextflow`.
Przy aktualizacji przypiętego commita uruchom `:TSUpdate nextflow` i zrestartuj
edytor, aby przeładować bibliotekę parsera oraz zapytania.

Podpowiedzi, definicje i diagnostyka wymagają oficjalnego **Nextflow Language
Server** oraz Javy 17 lub nowszej.

Pobierz `language-server-all.jar` z wydań:

https://github.com/nextflow-io/language-server/releases

i zapisz go jako:

```text
~/.local/share/nextflow-ls/language-server-all.jar
```

Na przykład najpierw utwórz katalog:

```bash
mkdir -p ~/.local/share/nextflow-ls
```

Konfiguracja sama wykryje plik `.jar`. Jeśli go nie ma, LSP Nextflow zostanie po
prostu pominięty — kolorowanie nadal będzie działać.

Sprawdzenie:

```vim
:checkhealth lsp
:lua =vim.lsp.get_clients()
```

## Aktualizacja pluginów

W Neovimie:

```vim
:PackUpdate
```

`vim.pack` pokaże podgląd aktualizacji. Po zaakceptowaniu zmian zaktualizuje też
`nvim-pack-lock.json`.

Konfiguracja ma hook `PackChanged`, który po aktualizacji `nvim-treesitter`
automatycznie uruchamia `:TSUpdate`, żeby wersje parserów pozostały zgodne z
pluginem.

Po aktualizacji sprawdź zmiany w Git i commituj lockfile razem z konfiguracją.

## Diagnostyka

Jeśli coś nie działa, zacznij od:

```vim
:checkhealth
:checkhealth vim.pack
:checkhealth nvim-treesitter
:checkhealth lsp
```

Przydatne polecenia systemowe:

```bash
nvim --version
rg --version
tree-sitter --version
lazygit --version
java --version
rustc --version
cargo --version
```

Typowe problemy:

- brak wyników w `<space>fg` → sprawdź, czy działa `rg`,
- puste kwadraty zamiast ikon → ustaw Nerd Font w terminalu,
- brak kolorowania po pierwszym uruchomieniu → poczekaj na instalację parserów i zrestartuj Neovima,
- brak LSP dla Pythona/Basha/Rusta → sprawdź `:Mason` i `:checkhealth lsp`,
- brak LSP dla Nextflow → sprawdź plik `.jar` i `java --version`,
- problemy z Treesitterem → sprawdź `tree-sitter --version` i `:checkhealth nvim-treesitter`.

## Struktura konfiguracji

```text
~/.config/nvim/
├── init.lua
├── nvim-pack-lock.json
└── lua/dawid/
    ├── options.lua
    ├── keymaps.lua
    └── plugins/
        ├── init.lua
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

- `init.lua` — punkt wejścia, leader i kolejność ładowania,
- `options.lua` — ustawienia Neovima,
- `keymaps.lua` — skróty niezależne od pluginów,
- `plugins/init.lua` — lista pluginów dla `vim.pack` i kolejność konfiguracji,
- pozostałe pliki w `plugins/` — konfiguracja konkretnych funkcji/pluginów.

Konfiguracja celowo nie używa rozbudowanego lazy-loadingu. Przy tej liczbie
pluginów prostota i łatwość diagnozowania są ważniejsze niż niewielki zysk czasu
startu.
