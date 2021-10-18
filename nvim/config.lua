local vim = vim

-- set up git stuff
require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n <leader>hn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n <leader>hp'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hP'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
}

local opts = {
  tools = { -- i-love-rust options

        -- maps keymap => functionnality
        -- see README.md
        keymaps = {
      ["<leader>a"] = "code actions",
      ["<leader>e"] = "line diagnostics",
      ["<leader>H"] = "open external doc",
      ["<leader>i"] = "incoming calls",
      ["gd"] = "declaration",
      ["gD"] = "definition",
      --[" o"] = "outgoing calls",
      ["<leader>p"] = "parent module",
      [" ql"] = "diagnostic locations",
      [" qL"] = "workspace diagnostic locations",
      ["<leader>qe"] = "error locations",
      ["<leader>qf"] = "quickfix",
      [" qu"] = "list unsafe",
      [" qU"] = "list worskpace unsafe",
      [" rd"] = "debug",
      ["gr"] = "references",
      [" rt"] = "related tests",
      ["<leader>rr"] = "run",
      [" rn"] = "rename",
      [" s"] = "signature help",
      ["<c-s>"] = "insert mode signature help",
      [" w"] = "select containing",
      [" W"] = "undo select containing",
      [" y"] = "token semantic",
      [" z"] = "fold",
      ["<F8>"] = "debugger scopes",
      ["<F9>"] = "debugger frames",
      ["<F10>"] = "debugger terminal",
      [" b"] = "debugger toggle breakpoint",
      [" B"] = "debugger n-hits breakpoint",
      [" c"] = "debugger continue",
      [" j"] = "debugger step over",
      [" J"] = "debugger stacktrace up",
      [" g"] = "debugger run to cursor",
      [" k"] = "debugger step out",
      [" K"] = "debugger stacktrace down",
      [" l"] = "debugger step into",
      [" v"] = "debugger expression",
      ["<C-k>"] = "move item up",
      ["<C-j>"] = "move item down",
      },

        -- show function signature in hover when the cursor is on '(' or after it in insert mode
        -- and show parameter name after or on ',' character
        auto_signature_help = false,

        --- highlight all occurence of the entity under the cursor
        setup_document_highlight = true,

        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- automatically set code lenses 
        -- There is an issue. For now, write to the file to trigger a reapplication of
        -- the code lenses or just run :RustSetCodeLens.
        -- default: true
        autoSetCodeLenses = false,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
        -- default: true
        hover_with_actions = true,

        -- These apply to the default RustRunnables command
        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true
            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "    ",
            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "   :",
            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "InlayHints"
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },
            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = true,
            -- weither code_actions appear in floating window (true) or
            -- in a dedicated window
            float_code_actions = true,
            -- weither hover appear in floating window
            float_hover = true
        },

        -- debugger support configuration
        dap_adapter = {
          type = 'executable',
          command = 'lldb-vscode',
          name = "rt_lldb"
        }

    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by i-love-rust.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    -- rust-analyer options
	  server = {
	  	settings = {
	  		["rust-analyzer"] ={
	  			hoverActions = {
	  				references = true,
	  			},
	  			lens = {
	  				methodReferences = true,
	  			},
          checkOnSave = {
            command = "clippy",
            allFeatures = true,
            checkOnSave = true,
          },
	 			}
	 		}
	 	}
}
require 'i-love-rust'.setup(opts)


local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --['<leader>c'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'crates' },
  },
})


vim.api.nvim_set_keymap("n", "<leader>fc", [[<cmd>lua vim.lsp.buf.formatting()<cr>]], {noremap = true})



local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    -- USE BAT INSTEAD OF CAT
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_better,
        ["<C-k>"] = actions.move_selection_worse,
        ["<C-q>"] = actions.send_to_qflist,
        ["<Esc>"] = actions.close
      },
    },
  }
}

-- Open git files if possible, if it errors out open normal find files
-- find files gives a preview and already ignores .gitingore files thanks to ripgrep
function search_files()
    local opts = {}
    require'telescope.builtin'.find_files(opts)
end

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

function set_binding(mode, key, command)
  local cmd = mode .. "noremap " .. key .. " " .. command
  vim.cmd(cmd)
end

set_binding('n', '<leader>ff', ':lua search_files()<cr>')
set_binding('n', '<leader>fg', ':lua require("telescope.builtin").live_grep()<cr>')
set_binding('n', '<leader>fb', ':lua search_in_buffer()<cr>')
set_binding('i', '<C-f>', '<Esc> :lua search_in_buffer()<cr>')
set_binding('n', '<leader>fs', ':lua search_symbols_workspace()<cr>')


require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  lsp_diagnostics     = true,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}

