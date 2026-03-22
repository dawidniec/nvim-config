local opt = vim.opt

opt.undofile = true
opt.undolevels = 10000

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.updatetime = 200

pcall(function()
	opt.clipboard = "unnamedplus"
end)

opt.confirm = true
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.splitbelow = true
opt.splitright = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

opt.showmode = false
opt.completeopt = "menu,menuone,noselect"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
