--[[ editor settings ]]--
local settings = {
	cdhome = true,
	confirm = true,
	clipboard = "unnamedplus",
	fileencoding = "utf-8",
	filetype = "on",
	mouse = "",
	mousehide = true,
	swapfile = false,
	undodir = "/home/zekiukas/.config/nvim/undo",
	undofile = true,
	updatetime = 50,
	


	autoindent = true,
	breakindent = true,
	copyindent = true,
	expandtab = true,
	preserveindent = true,
	smartindent = true,
	smarttab = true,
	shiftwidth = 4,
	softtabstop = 4,
	tabstop = 4,


    
	cursorline= true,
	colorcolumn = "100",
	guicursor = "a:block,i:ver50,v:hor50,r:hor50",
    laststatus = 3, 
	number = true,
	relativenumber = true,
	scrolloff = 4,
	sidescrolloff = 4,
	showmode = false,
	signcolumn = "yes",
    splitbelow = true,
    splitright = true,
	termguicolors = true,
	wrap = true,
	wrapmargin = 8,


	hlsearch = false,
	incsearch = true,
	ignorecase = true,
    cmdheight = 1,
}

for k, v in pairs(settings) do
	vim.opt[k] = v
end
