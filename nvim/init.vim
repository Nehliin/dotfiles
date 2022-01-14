" auto-install vim-plug
if empty(glob(stdpath('data') . '/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin(stdpath('data') . '/autoload/plugged')
" Auto pairs for '(' '[' '{' and surround
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" Airline
Plug 'vim-airline/vim-airline'
" Buffer bar
Plug 'romgrk/barbar.nvim'
" Recommended (for coloured icons for files)
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kyazdani42/nvim-tree.lua'
" Set root directory properly
Plug 'airblade/vim-rooter'
" Git in the gutter
Plug 'lewis6991/gitsigns.nvim'
" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/playground'
" Dracula
Plug 'dracula/vim', { 'as': 'dracula' }
" Lsp stuff
Plug 'neovim/nvim-lspconfig'
" Makes code actions pop up work
Plug 'hood/popui.nvim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'    
" Foundational
Plug 'nvim-telescope/telescope.nvim'
Plug 'romgrk/fzy-lua-native'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-lua/plenary.nvim'
" Rust
Plug 'simrat39/rust-tools.nvim'
Plug 'saecki/crates.nvim'
" Debugging rust
Plug 'mfussenegger/nvim-dap'
"Completion support
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
" Whole project lsp diagnostics
Plug 'folke/trouble.nvim'
"auto save
Plug '907th/vim-auto-save'
call plug#end()

let g:config_root = stdpath('config')

execute 'source ' . g:config_root . '/general.vim'
execute 'luafile ' . g:config_root . '/config.lua'
execute 'source ' . g:config_root . '/mappings.lua'
execute 'luafile ' . g:config_root . '/tree-sitter-config.lua'

nnoremap <leader>rl :execute 'source ' . g:config_root . '/init.vim'<CR>

"Autosave
let g:auto_save = 1

" File tree
highlight NvimTreeFolderIcon guibg=blue

" this variable must be enabled for colors to be applied properly
set termguicolors

colorscheme dracula
set guifont="JetBrainsMono NF"
let g:neovide_transparency=1
