local vim = vim

-- enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
}

capabilities.experimental = {}
capabilities.experimental.hoverActions = true

local nvim_lsp = require'lspconfig'

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
})

require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

local opts = {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = ":",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "->",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
            allFeatures = true,
            checkOnSave = true,
          },
        },
      },
    }, -- rust-analyer options
}
require('rust-tools').setup(opts)


vim.api.nvim_set_keymap("n", "<leader>.", [[<cmd>lua require('rust-tools.hover_actions').hover_actions()<cr>]], {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rr", [[<cmd>lua require('rust-tools.runnables').runnables()<cr>]], {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fc", [[<cmd>lua vim.lsp.buf.formatting()<cr>]], {noremap = true})

--vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

vim.o.completeopt = "menuone,noselect"

require 'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200; incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
    crates = true;
  };
}

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
  --  local ok = pcall(require'telescope.builtin'.git_files, opts)

   -- if not ok then
       require'telescope.builtin'.find_files(opts)
   -- end
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

vim.o.termguicolors = true
