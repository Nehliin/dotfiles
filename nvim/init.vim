call plug#begin(stdpath('data') . '/plugged')
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'kyazdani42/nvim-web-devicons' 
" Recommended (for coloured icons)
Plug 'ryanoasis/vim-devicons'
" for file icons
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'
" Set root directory properly
Plug 'airblade/vim-rooter'
"Git in the gutter
Plug 'mhinz/vim-signify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
" Dracula
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'    
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/playground'
Plug 'mhinz/vim-startify'
Plug '907th/vim-auto-save'
call plug#end()

source  $HOME/AppData/Local/nvim/general.vim
source  $HOME/AppData/Local/nvim/lsp-config.vim

luafile $HOME/AppData/Local/nvim/tree-sitter-config.lua
luafile $HOME/AppData/Local/nvim/config.lua

nnoremap <leader>rl :source $HOME/AppData/Local/nvim/init.vim<CR>

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
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Window splitting
nnoremap <Leader>sv :vsplit<CR>
nnoremap <Leader>sc :split<CR>

"Autosave
let g:auto_save = 1

" file tree settings 
" this variable must be enabled for colors to be applied properly
set termguicolors
" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue


colorscheme dracula
set guifont="Jetbrains Mono"
let g:neovide_transparency=1
