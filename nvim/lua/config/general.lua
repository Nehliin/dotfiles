-- encoding to be displayed
vim.opt.encoding = "utf-8"
-- encoding written to file
vim.opt.fileencoding = "utf-8"
-- show the cursor position all the time
vim.opt.ruler = true
-- more screenspace
vim.opt.cmdheight = 0
vim.opt.numberwidth = 2
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
-- support more colors (t_Co=256?)
vim.opt.termguicolors = true
-- show 10 lines above and below selected
vim.opt.scrolloff = 10
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.laststatus = 3

vim.cmd("colorscheme tokyonight")

require('lualine').setup {}

require('gitsigns').setup {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
  
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
  
      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end)
  
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end)
  
      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)
      map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hu', gitsigns.undo_stage_hunk)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hn', gitsigns.next_hunk)
      map('n', '<leader>hp', gitsigns.prev_hunk)
      map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>hd', gitsigns.preview_hunk)
      map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
      map('n', '<leader>td', gitsigns.toggle_deleted)
  
      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
  
  vim.g.rustaceanvim = {
    -- Plugin configuration
    -- LSP configuration
    server = {
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
  }
  
require('autosave').setup()
vim.g.autosave_disable_inside_paths = { vim.fn.stdpath('config') }

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust", "just" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}