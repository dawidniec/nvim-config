local aucmd = vim.api.nvim_create_autocmd

-- 1. Start Treesitter highlighting automatically
aucmd("FileType", {
    pattern = { "bash", "python", "javascript", "lua", "c" },
    callback = function()
        vim.treesitter.start()
        -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

aucmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

