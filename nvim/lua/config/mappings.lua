local nnoremap = function(lhs, rhs, silent)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

local inoremap = function(lhs, rhs)
	vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true })
end

local inosilentexprremap = function(lhs, rhs)
	vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true, expr = true, silent = true })
end

local vnoremap = function(lhs, rhs)
	vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true })
end

-- Use alt + hjkl to resize windows
nnoremap("<M-j>", ":resize -2<CR>")
nnoremap("<M-k>", ":resize +2<CR>")
nnoremap("<M-h>", ":vertical resize -2<CR>")
nnoremap("<M-l>", ":vertical resize +2<CR>")

-- Escape redraws the screen and removes any search highlighting.
nnoremap("<esc>", ":noh<return><esc>")

-- Window splitting
nnoremap("<Leader>sv", ":vsplit<CR>")
nnoremap("<Leader>sc", ":split<CR>")

-- Better tabbing
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- TAB in normal mode will move to text buffer
--nnoremap("<TAB>", ":BufferNext<CR>")
-- SHIFT-TAB will go back
--nnoremap("<S-TAB>", ":BufferPrevious<CR>")
--nnoremap("<Leader>q", ":BufferClose<CR>")

-- NvimTree
--nnoremap("<Leader>o", ":NvimTreeToggle<CR>")

-- Move stuff
nnoremap("J", "<cmd>lua vim.cmd.RustLsp { 'moveItem', 'down'}", true)
nnoremap("K", "<cmd>lua vim.cmd.RustLsp { 'moveItem', 'up'}<CR>", true)

-- LSP
nnoremap("ge", "<cmd>lua vim.diagnostic.goto_prev()<CR>", true)
nnoremap("gE", "<cmd>lua vim.diagnostic.goto_next()<CR>", true)
nnoremap("<silent><leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
nnoremap("<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", true)
nnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
vnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
nnoremap("<Leader>e", '<cmd>lua vim.diagnostic.open_float({scope="line"})<CR>', true)
nnoremap("<Leader>.", '<cmd>lua vim.lsp.buf.hover()<CR>', true)
nnoremap("<Leader>rr", "<cmd>lua vim.cmd.RustLsp('runnables')<CR>", true)
nnoremap("<Leader>rb", "<cmd>lua vim.cmd.RustLsp('debuggables')<CR>", true)
nnoremap("<Leader>fc", "<cmd>lua vim.lsp.buf.format()<CR>", true)

vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua require("snacks").terminal()<CR>')
