local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

vim.cmd("colorscheme gruvbox")

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Set up nvim tree 
require'nvim-tree'.setup {
  git = {
      ignore = true,
  },
}

local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "rust-gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

local dap = require("dap")
dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
       local name = vim.fn.input('Executable name (filter): ')
       return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:1234',
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}'
  },
}

-- set up git in the gutter
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
      ['n <leader>hd'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
      ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
      ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
  
      -- Text objects
      ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
      ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    },
}

-- Use these for non rust lsp capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

P = function(v)
  print(vim.inspect(v))
  return v
end


vim.g.rustaceanvim = {
  -- Plugin configuration
  -- tools = {
  -- },
  -- LSP configuration
  server = {
    --on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    --end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
            cargo = {
                runBuildScripts = true,
            },
            check = {
                command = "clippy",
                enable = true,
            },
      },
    },
  },
  -- DAP configuration
  --dap = {
  --},
}




local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--hidden',
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
require('telescope').load_extension("fzy_native")

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "crates" },
        { name = "nvim_lsp_signature_help" },
	},
})

require('nvim-treesitter')

--require 'nvim-treesitter.install'.compilers = { "gcc","clang" }

require 'nvim-treesitter.configs'.setup {
    autotag = {
        enable = true,
      },
      indent = {
        enable = true
      },
      highlight = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      context_commentstring = { enable = true },
}

vim.ui.select = require"popui.ui-overrider"
vim.ui.input = require"popui.input-overrider"
