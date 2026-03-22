return {
	{
		"nvim-mini/mini.statusline",
		version = "*",
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },

		-- 'init' wywołuje się jeszcze przed pełnym załadowaniem wtyczki
		init = function()
			-- Włącza globalny pasek statusu dla wszystkich otwartych podziałów (splitów)
			vim.o.laststatus = 3
		end,

		opts = {
			-- Ważne: Zatrzymujemy domyślne zachowanie wtyczki, które wymusiłoby powrót do laststatus=2
			set_vim_settings = false,

			-- Opcjonalnie: dostosowanie zawartości paska
			-- (Jeśli zechcesz zmienić to, co wyświetla się na pasku, odkomentuj ten fragment i go modyfikuj)
			--[[
            content = {
                active = function()
                    local MiniStatusline = require('mini.statusline')
                    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                    local git           = MiniStatusline.section_git({ trunc_width = 75 })
                    local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                    local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
                    local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                    local location      = MiniStatusline.section_location({ trunc_width = 75 })

                    -- Łączenie poszczególnych modułów w cały pasek
                    return MiniStatusline.combine_groups({
                        { hl = mode_hl,                  strings = { mode } },
                        { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
                        '%<', -- Znacznik: tutaj obcinaj długi tekst (jeśli okno jest wąskie)
                        { hl = 'MiniStatuslineFilename', strings = { filename } },
                        '%=', -- Znacznik: "wypchnij" wszystko, co jest poniżej, na prawą stronę ekranu
                        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                        { hl = mode_hl,                  strings = { location } },
                    })
                end
            }
            --]]
		},
	},
}
