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
nnoremap("gE", "<cmd>lua vim.diagnostic.goto_prev()<CR>", true)
nnoremap("ge", "<cmd>lua vim.diagnostic.goto_next()<CR>", true)
nnoremap("<silent><leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
nnoremap("<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", true)
nnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
vnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
nnoremap("<Leader>e", '<cmd>lua vim.diagnostic.open_float({scope="line"})<CR>', true)
nnoremap("<Leader>.", '<cmd>lua vim.lsp.buf.hover()<CR>', true)
nnoremap("<Leader>rr", "<cmd>lua vim.cmd.RustLsp('runnables')<CR>", true)
nnoremap("<Leader>rb", "<cmd>lua vim.cmd.RustLsp('debuggables')<CR>", true)
nnoremap("<Leader>fc", "<cmd>lua vim.lsp.buf.format()<CR>", true)

-- Snacks
local map = function(lhs, rhs, desc, mode, opts)
    vim.keymap.set(mode or "n", lhs, rhs, vim.tbl_extend("force", { desc = desc, silent = true }, opts or {}))
end

-- Pickers
map("<leader><space>", function() Snacks.picker.smart() end, "Smart Find Files")
map("/",               function() Snacks.picker.lines() end, "Search buffer lines")
map("<leader>:",       function() Snacks.picker.command_history() end, "Command History")
map("<leader>n",       function() Snacks.picker.notifications() end, "Notification History")
map("<leader>o",       function() require('nvim-tree.api').tree.toggle() end, "File Explorer")

-- Find
map("<leader>fb", function() Snacks.picker.buffers() end, "Buffers")
map("<leader>ff", function() Snacks.picker.files() end, "Find Files")
map("<leader>fg", function() Snacks.picker.grep() end, "Grep")
map("<leader>fp", function() Snacks.picker.projects() end, "Projects")
map("<leader>fr", function() Snacks.picker.recent() end, "Recent")

-- Git
map("<leader>gb", function() Snacks.picker.git_branches() end, "Git Branches")
map("<leader>gB", function() Snacks.gitbrowse() end, "Git Browse", { "n", "v" })
map("<leader>gd", function() Snacks.picker.git_diff() end, "Git Diff (Hunks)")
map("<leader>gf", function() Snacks.picker.git_log_file() end, "Git Log File")
map("<leader>gg", function() Snacks.lazygit() end, "Lazygit")
map("<leader>gl", function() Snacks.picker.git_log() end, "Git Log")
map("<leader>gL", function() Snacks.picker.git_log_line() end, "Git Log Line")
map("<leader>gs", function() Snacks.picker.git_status() end, "Git Status")
map("<leader>gS", function() Snacks.picker.git_stash() end, "Git Stash")

-- Search
map('<leader>s"', function() Snacks.picker.registers() end, "Registers")
map('<leader>s/', function() Snacks.picker.search_history() end, "Search History")
map("<leader>sa", function() Snacks.picker.autocmds() end, "Autocmds")
map("<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines")
map("<leader>sB", function() Snacks.picker.grep_buffers() end, "Grep Open Buffers")
map("<leader>sC", function() Snacks.picker.commands() end, "Commands")
map("<leader>sd", function() Snacks.picker.diagnostics() end, "Diagnostics")
map("<leader>sD", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
map("<leader>sg", function() Snacks.picker.grep() end, "Grep")
map("<leader>sh", function() Snacks.picker.help() end, "Help Pages")
map("<leader>sH", function() Snacks.picker.highlights() end, "Highlights")
map("<leader>si", function() Snacks.picker.icons() end, "Icons")
map("<leader>sj", function() Snacks.picker.jumps() end, "Jumps")
map("<leader>sk", function() Snacks.picker.keymaps() end, "Keymaps")
map("<leader>sl", function() Snacks.picker.loclist() end, "Location List")
map("<leader>sm", function() Snacks.picker.marks() end, "Marks")
map("<leader>sM", function() Snacks.picker.man() end, "Man Pages")
map("<leader>sq", function() Snacks.picker.qflist() end, "Quickfix List")
map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
map("<leader>su", function() Snacks.picker.undo() end, "Undo History")
map("<leader>sw", function() Snacks.picker.grep_word() end, "Visual selection or word", { "n", "x" })
map("<leader>,",  function() Snacks.picker.resume() end, "Resume")

-- LSP (via Snacks picker)
map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
map("gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration")
map("gi", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
map("gr", function() Snacks.picker.lsp_references() end, "References", "n", { nowait = true })
map("gy", function() Snacks.picker.lsp_type_definitions() end, "Goto T[y]pe Definition")
map("<leader>fs", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")

-- UI toggles
map("<leader>uC", function() Snacks.picker.colorschemes() end, "Colorschemes")
map("<leader>un", function() Snacks.notifier.hide() end, "Dismiss All Notifications")

-- Other
map("<leader>bd", function() Snacks.bufdelete() end, "Delete Buffer")
map("<leader>cR", function() Snacks.rename.rename_file() end, "Rename File")
map("<leader>S",  function() Snacks.scratch.select() end, "Select Scratch Buffer")
map("<leader>z",  function() Snacks.zen() end, "Toggle Zen Mode")
map("<leader>Z",  function() Snacks.zen.zoom() end, "Toggle Zoom")
map("<leader>N",  function()
    Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
    })
end, "Neovim News")

map("]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference", { "n", "t" })
map("[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference", { "n", "t" })

-- Terminal
map("<C-t>", function() Snacks.terminal() end, "Toggle Terminal", { "n", "t" })
map("<c-_>", function() Snacks.terminal() end, "Toggle Terminal", { "n", "t" })
