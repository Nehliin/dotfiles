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
" file bars
Plug 'romgrk/barbar.nvim'

" Set root directory properly
Plug 'airblade/vim-rooter'

" Recommended (for coloured icons for files)
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kyazdani42/nvim-tree.lua'

"Git in the gutter
Plug 'lewis6991/gitsigns.nvim'


" Tresitter 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/playground'
" Dracula
Plug 'dracula/vim', { 'as': 'dracula' }

" LSP stuff
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'RishabhRD/nvim-lsputils'    

"foundational
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

"unknown
Plug 'nvim-lua/popup.nvim'
Plug 'RishabhRD/popfix'

" Rust stuff
let g:i_love_rust_key_bindings = 1 
Plug 'https://gitlab.com/okannen/i-love-rust.nvim'
Plug 'saecki/crates.nvim'
" Debugging rust
Plug 'mfussenegger/nvim-dap'

"Completion support 
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

"auto save
Plug '907th/vim-auto-save'
call plug#end()

let g:config_root = stdpath('config')

execute 'source ' . g:config_root . '/general.vim'
execute 'source ' . g:config_root . '/lsp-config.vim'
execute 'luafile ' . g:config_root . '/config.lua'
execute 'luafile ' . g:config_root . '/tree-sitter-config.lua'

nnoremap <leader>rl :execute 'source ' . g:config_root . '/init.vim'<CR>

function! SmartQuit()
    let num_buffers = len(getbufinfo({'buflisted':1}))
    if num_buffers == 1
      try
        execute ":silent quit"
      catch /E37:/
        " Unwritten changes
        echo "E37: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: "
        let ans = nr2char(getchar())
        if ans == "y" || ans == "Y"
          execute "quit!"
        elseif  ans == "w" || ans == "W"
          execute "write"
          execute "quit"
        else
          call feedkeys('\<ESC>')
        endif
      endtry
    else
      try
        execute "bd"
      catch /E89:/
        " Unwritten changes
        echo "E89: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: "
        let ans = nr2char(getchar())
        if ans == "y" || ans == "Y"
          execute "bd!"
        elseif  ans == "w" || ans == "W"
          execute "write"
          execute "bd"
        else
          call feedkeys('\<ESC>')
        endif
      endtry
    endif
endfunction

nnoremap <leader>qq :call SmartQuit()<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Escape redraws the screen and removes any search highlighting.
nnoremap <esc> :noh<return><esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :BufferNext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :BufferPrevious<CR>
nnoremap <leader>q :BufferClose<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move visual selection up and down a line
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv 

" Quickly re-select either the last pasted or changed text
noremap gV `[v`]

"Window splitting
nnoremap <Leader>sv :vsplit<CR>
nnoremap <Leader>sc :split<CR>

"Autosave
let g:auto_save = 1

" File tree
nnoremap <Leader>o :NvimTreeToggle<CR>

" this variable must be enabled for colors to be applied properly
set termguicolors

"Nvim tree 
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.target'] "empty by default
highlight NvimTreeFolderIcon guibg=blue

colorscheme dracula
set guifont="JetBrainsMono NF"
let g:neovide_transparency=1
