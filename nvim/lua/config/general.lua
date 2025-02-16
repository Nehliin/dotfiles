-- enable syntax highliting
vim.opt.syntax = "enable"
-- encoding to be displayed
vim.opt.encoding = "utf-8"
-- encoding written to file
vim.opt.fileencoding = "utf-8"
-- show the cursor position all the time
vim.opt.ruler = true
-- more space for displaying messages
vim.opt.cmdheight = 2
-- Treat dash separated words as word text objects
vim.opt.iskeyword:append('-')
    -- enable mouse
vim.opt.mouse = "a"
-- horizontal splits are opened below
vim.opt.splitbelow = true
-- vertical splits are opened to the right
vim.opt.splitright = true
-- don't hide `` in markdown files
vim.opt.conceallevel = 0
-- insert 4 spaces for a tab
vim.opt.tabstop = 4
-- change number of space characters inserted for indentation
vim.opt.shiftwidth = 4
-- make tabbing smarted
vim.opt.smarttab = true
-- convert tab to spaces
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
-- show line numbers
vim.opt.number = true
-- hightlight current line
vim.opt.cursorline = true
-- default background color
vim.opt.background = "dark"
-- always show tabs
vim.opt.showtabline = 4
-- faster completion
vim.opt.updatetime = 300
-- default is 1000
vim.opt.timeoutlen = 500
-- stop newline continuation of comments
vim.opt.formatoptions:remove("cro")
-- copy paste between vim and everything else
vim.opt.clipboard = "unnamedplus"
-- automatically change directory
vim.opt.autochdir = true
-- support more colors (t_Co=256?)
vim.opt.termguicolors = true
-- set default textwidth
vim.opt.textwidth = 800
-- show 10 lines above and below selected
vim.opt.scrolloff = 10
vim.opt.completeopt = "menuone,noinsert,noselect"


vim.cmd("colorscheme shadow")

vim.opt.laststatus = 3