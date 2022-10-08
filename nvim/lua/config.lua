local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

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

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
-- Set up nvim tree 
require'nvim-tree'.setup {
  git = {
      ignore = true,
  },
  open_on_setup = true,
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

P = function(v)
  print(vim.inspect(v))
  return v
end

local rt = require('rust-tools')
rt.setup {
    tools = { -- rust-tools options
        inlay_hints = {
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = ":",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "->",
        },
        snippet_func = function(edits, bufnr, offset_encoding, old_func)
            P(edits)
            require("luasnip.extras.lsp").apply_text_edits(
                edits,
                bufnr,
                offset_encoding,
                old_func
        )
        end,
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        on_attach = function(client, bufnr)
           vim.keymap.set(
                "n",
                "<Leader>.",
                rt.hover_actions.hover_actions,
                { buffer = bufnr }
           )
    
           --vim.keymap.set(
           --    "n",
           --   "<Leader>a",
           --    rt.code_action_group.code_action_group,
           --     { buffer = bufnr }
           -- )
            end,
        settings = {
            ["rust-analyzer"] = {
              cargo = {
                  allFeatures = true,
                  autoreload = true,
                  runBuildScripts = true,
              },
              checkOnSave = {
                command = "clippy",
                checkOnSave = true,
                extraArgs = {"--target-dir", "/home/oskar/Desktop/rust-analyzer/rust-analyzer-check"},
              },
            },
        },
    }
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
