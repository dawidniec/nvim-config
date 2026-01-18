vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true

opt.number = true
opt.relativenumber = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.showmode = false
opt.inccommand = "split"

--[[
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99             -- Start with all folds open
opt.foldcolumn = "0"           -- Show fold indicators in the margin
opt.foldtext = ""              -- Modern Neovim 0.10+ clean foldsopt.ignorecase = true
opt.foldenable = true
--]]

opt.smartcase = true
opt.hlsearch = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.scrolloff = 3


