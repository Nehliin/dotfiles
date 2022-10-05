local vim = vim


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

require'crates'.setup({})

require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

-- Set up nvim tree 
require'nvim-tree'.setup {
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close = true,
  git = {
      ignore = true,
  },
  filter = {
      custom = {'.git', 'node_modules', '.cache', '.target'},
  },
}

require'trouble'.setup{}

-- enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--local lsp_installer = require("nvim-lsp-installer")

--local servers = {
 --   "clangd",
--}

-- Loop through the servers listed above.
--for _, server_name in pairs(servers) do
--    local server_available, server = lsp_installer_servers.get_server(server_name)
--    if server_available then
--        server:on_ready(function ()
            -- When this particular server is ready (i.e. when installation is finished or the server is already installed),
            -- this function will be invoked. Make sure not to use the "catch-all" lsp_installer.on_server_ready()
            -- function to set up servers, to avoid doing setting up a server twice.
--            local opts = {}
--            server:setup(opts)
--        end)
--        if not server:is_installed() then
            -- Queue the server to be installed.
--            server:install()
--       end
--    end
--end

local opts = {
    tools = { -- rust-tools options
        inlay_hints = {
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = ":",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "->",
        },
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
      on_attach = function()
			vim.cmd([[au BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
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
          inlayHints = {
              lifetimeElisionHints = true,
              reborrowHints = true,
          },
        },
      },
    }, -- rust-analyer options
}
require('rust-tools').setup(opts)


vim.ui.select = require"popui.ui-overrider"
--vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler

local bufnr = vim.api.nvim_buf_get_number(0)

    vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
        require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
    end

vim.opt.completeopt = "menuone,noinsert,noselect"
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
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
		{ name = "vsnip" },
		{ name = "buffer" },
		{ name = "crates" },
	},
})


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

