return {
    {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	lazy = false,
	build = ':TSUpdate',
	config = function()
	    local ts = require('nvim-treesitter')
	    ts.setup({
		highlight = { enable = true },
		indent = { enable = true },
		install = {
		    parsers = { "python", "json", "yaml", "bash", "toml", "javascript", }
		},
	    })
	end
    },
}
