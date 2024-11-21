-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Left column and similar settings
vim.opt.number = true -- display line numbers
vim.opt.relativenumber = true -- display relative line numbers
vim.opt.numberwidth = 2 -- set width of line number column
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.wrap = false -- display lines as single line
vim.opt.scrolloff = 10 -- number of lines to keep above/below cursor
vim.opt.sidescrolloff = 8 -- number of columns to keep to the left/right of cursor

-- Tab spacing/behavior
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- number of spaces inserted for each indentation level
vim.opt.tabstop = 2 -- number of spaces inserted for tab character
vim.opt.softtabstop = 2 -- number of spaces inserted for <Tab> key
vim.opt.smartindent = true -- enable smart indentation
vim.opt.breakindent = true -- enable line breaking indentation

-- General Behaviors
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.backup = false -- disable backup file creation
vim.opt.clipboard = "unnamedplus" -- enable system clipboard access
vim.opt.conceallevel = 0 -- show concealed characters in markdown files
vim.opt.fileencoding = "utf-8" -- set file encoding to UTF-8
vim.opt.mouse = "a" -- enable mouse support
vim.opt.showmode = false -- hide mode display
vim.opt.splitbelow = true -- force horizontal splits below current window
vim.opt.splitright = true -- force vertical splits right of current window
vim.opt.termguicolors = true -- enable term GUI colors
vim.opt.timeoutlen = 1000 -- set timeout for mapped sequences
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 100 -- set faster completion
vim.opt.writebackup = false -- prevent editing of files being edited elsewhere
vim.opt.cursorline = true -- highlight current line
vim.opt.swapfile = false -- creates a swapfile

-- Searching Behaviors
vim.opt.hlsearch = true -- highlight all matches in search
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- match case if explicitly stated
vim.opt.colorcolumn = "120"
vim.opt.guicursor = "n-v-c:block,i-ci:ver25,r-cr:hor20,o:hor50"
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "javascript,typescript",
--     callback = function()
--         vim.opt_local.expandtab = true
--         vim.opt_local.shiftwidth = 2
--         vim.opt_local.tabstop = 2
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "java",
--     callback = function()
--         vim.opt_local.expandtab = true
--         vim.opt_local.shiftwidth = 4
--         vim.opt_local.tabstop = 4
--     end,
-- })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
			vim.opt_local.shiftwidth = 2
			vim.opt_local.tabstop = 2
		elseif vim.bo.filetype == "java" then
			vim.opt_local.shiftwidth = 4
			vim.opt_local.tabstop = 4
		end
	end,
})

