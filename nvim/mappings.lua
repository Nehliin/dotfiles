function smartquit()
    local buf_nums = vim.fn.len(vim.fn.getbufinfo({buflisted = 1}))

    if buf_nums == 1 then
        local ok = pcall(vim.cmd, ":silent quit")
        if not ok then
            local choice = vim.fn.input(
                               "E37: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: ")
            if choice == "y" then
                vim.cmd "quit!"
            elseif choice == "w" then

                vim.cmd "write"
                vim.cmd "quit"
            else
                vim.fn.feedkeys('\\<ESC>')
            end

        end
    else

        local ok = pcall(vim.cmd, "bw")

        if not ok then

            local choice = vim.fn.input(
                               "E37: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: ")
            if choice == "y" then
                vim.cmd "bw!"
            elseif choice == "w" then

                vim.cmd "write"
                vim.cmd "bw"
            else
                vim.fn.feedkeys('\\<ESC>')
            end

        end
    end
end

-- Open git files if possible, if it errors out open normal find files
-- find files gives a preview and already ignores .gitingore files thanks to ripgrep
function search_files()
    local opts = {}
  --  local ok = pcall(require'telescope.builtin'.git_files, opts)

   -- if not ok then
       require'telescope.builtin'.find_files(opts)
   -- end
end

local actions = require('telescope.actions')
function search_in_buffer()
    local opts = {
      attach_mappings = function(_, map)
        map('i', '<C-j>', actions.move_selection_next)
        map('i', '<C-k>', actions.move_selection_previous)

        -- Continue with the other mappings
        return true
        end,
    }
    require'telescope.builtin'.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown(opts))
end

function search_symbols_workspace()
    local opts = {
      attach_mappings = function(_, map)
        map('i', '<C-j>', actions.move_selection_next)
        map('i', '<C-k>', actions.move_selection_previous)

        -- Continue with the other mappings
        return true
        end,
    }
    require('telescope.builtin').lsp_workspace_symbols(require('telescope.themes').get_dropdown(opts))
end



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

-- smartquit
nnoremap("qq", "<cmd>lua smartquit()<CR>", true)
-- Use alt + hjkl to resize windows
nnoremap("<M-j>", ":resize -2<CR>")
nnoremap("<M-k>", ":resize +2<CR>")
nnoremap("<M-h>", ":vertical resize -2<CR>")
nnoremap("<M-l>", ":vertical resize +2<CR>")

-- Escape redraws the screen and removes any search highlighting.
nnoremap("<esc>", ":noh<return><esc>")

-- Better window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Window splitting
nnoremap("<Leader>sv", ":vsplit<CR>")
nnoremap("<Leader>sc", ":split<CR>")

-- Better tabbing
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- TAB in normal mode will move to text buffer
nnoremap("<TAB>", ":bnext<CR>")
-- SHIFT-TAB will go back
nnoremap("<S-TAB>", ":bprevious<CR>")

-- NvimTree
nnoremap("<Leader>o", ":NvimTreeToggle<CR>")

-- Move stuff
nnoremap("J", "<cmd>lua require('rust-tools.move_item').move_item(false)<CR>", true)
nnoremap("K", "<cmd>lua require('rust-tools.move_item').move_item(true)<CR>", true)

-- LSP
nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", true)
nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", true)
nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", true)
--nnoremap("gr", "<cmd>LspTrouble lsp_references<CR>", true)
nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", true)
nnoremap("<Leader>.", "<cmd>lua require('rust-tools.hover_actions').hover_actions()<CR>", true)
nnoremap("<Leader>rr", "<cmd>lua require('rust-tools.runnables').runnables()<CR>", true)
vnoremap("<C-space>", "<cmd>RustHoverRange<CR>")

nnoremap("gE", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", true)
nnoremap("ge", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", true)
nnoremap("<silent><leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
nnoremap("<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", true)
nnoremap("<Leader>fc", "<cmd>lua vim.lsp.buf.formatting()<CR>", true)
nnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", true)
vnoremap("<Leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")

--nnoremap("<Leader>ld", "<cmd>LspTrouble lsp_definitions<CR>", true)
nnoremap("<Leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", true)
nnoremap("<Leader>ae", "<cmd>LspTroubleWorkspaceToggle<CR>", true)

-- Telescope
nnoremap("<Leader>ff", '<Esc> :lua search_files()<CR>')
nnoremap("<Leader>fg", '<Esc> :lua require("telescope.builtin").live_grep()<CR>')
nnoremap("<Leader>fb", '<Esc> :lua search_in_buffer()<CR>')
nnoremap("<Leader>fs", '<Esc> :lua search_symbols_workspace()<CR>')

