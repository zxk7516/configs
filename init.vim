"************************************************************************************************
"********************************************  PLUG  ********************************************
"************************************************************************************************
call plug#begin('~/.vim/plugged')
"Languages~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'leafgarland/typescript-vim'
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ianks/vim-tsx'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'iloginow/vim-stylus'
"Special~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'gotcha/vimpdb'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'nelstrom/vim-visual-star-search'
"Plug 'ap/vim-buftabline'
Plug 'sjl/gundo.vim'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
"Git~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Themes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'icymind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim'
Plug 'jacoborus/tender.vim'
call plug#end()

"************************************************************************************************
"********************************************  SETS  ********************************************
"************************************************************************************************
filetype plugin indent on
syntax enable
set tags+=~/programming
set updatetime=250
"set relativenumber
"set lazyredraw
set complete -=t
set complete -=i
set number
set hlsearch
set wildmenu
set encoding=utf8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set history=10000
set shada+='1000
set ruler
set confirm
set incsearch
set autochdir
set list listchars=tab:→\ ,trail:·
set wildmode=full
set hidden
set showcmd
set termguicolors
set laststatus=2
set wildignore+=**/node_modules/**
set wildignore+=**/bower_components/**
set wildignore+=tags
set smarttab
set ignorecase
set infercase
set smartcase
set nofoldenable
set backup
set backupcopy=yes
set backupdir=~/.nvim/_backup/
set undofile
set undodir=~/.nvim/_undo/
set undolevels=1000
set undoreload=10000
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set path=~/projects/**/*
set mouse=a
set noswapfile
set background=dark
set inccommand=nosplit
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set belloff=all
set guicursor=
colorscheme tender
"hi Normal guibg=NONE
"highlight Number guifg=#d33682
"highlight Boolean guifg=#cb4b16
"auto insert in terminal
autocmd WinEnter term://* startinsert
autocmd FileType go setlocal noexpandtab
autocmd FileType ruby call UseSpacesTwo()
"autocmd BufLeave term://* stopinsert
"bufTab
""highlight BufTabLineCurrent guifg=#ededed guibg=#356dc6
""highlight BufTabLineActive guifg=#ededed
"highlight end of buffer
execute 'highlight link EndOfBuffer ColorColumn'
"augroup CursorLineOnlyInActiveWindow
"    autocmd!
"    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"    autocmd WinLeave * setlocal nocursorline
"augroup END
"toggle cursorline
"autocmd InsertLeave,WinEnter * set cursorline
"autocmd InsertEnter,WinLeave * set nocursorline
"statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf(
                \ 'W:%d E:%d',
                \ l:all_non_errors,
                \ l:all_errors
                \)
endfunction
function! Current_git_branch()
    let l:branch = split(fugitive#statusline(),'[()]')
    if len(l:branch) > 1
        return remove(l:branch, 1)
    endif
    return ""
endfunction
"au InsertLeave * hi Cursor guibg=white
"au InsertEnter * hi Cursor guibg=green
set statusline=
set statusline+=\%*
set statusline+=%3*\ %F
set statusline+=%5*
set statusline+=\ %{Current_git_branch()}
set statusline+=%4*\ %m
set statusline+=%3*
set statusline+=%=
set statusline+=%4*\ %{LinterStatus()}\ 
set statusline+=%3*
set statusline+=%2*\%l
set statusline+=%3*\:
set statusline+=%2*\%L
set statusline+=%3*\::
set statusline+=%2*\%c
set statusline+=%3*\ \ %*
hi User1 guifg=#FFFFFF guibg=#191f26 gui=BOLD
hi User2 guifg=#000000 guibg=#959ca6
hi User3 guifg=#000000 guibg=#7c90af gui=ITALIC
hi User4 guifg=#ff0000 guibg=#7c90af gui=BOLD
hi User5 guifg=#ffffff guibg=#7c90af gui=BOLD

" spaces
function! UseSpacesTwo()
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
endfunction

function! UseSpacesFour()
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
    setlocal expandtab
endfunction

" tabs
function! UsetTabsFour()
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
    setlocal noexpandtab
endfunction

"************************************************************************************************
"********************************************  MAPPINGS  ****************************************
"************************************************************************************************
let mapleader = "\<Space>"
"map ctrl+space space (exit from autocomplete)
inoremap <C-Space> <Space>
"reload VIMRC
map <f1> :exec "so $MYVIMRC" <cr>
"python
"map <f6> :w<cr>:exec "w !python3" <cr>
autocmd FileType python nnoremap <buffer> <f5> :w<cr> :exec "w !python3" <cr>
autocmd FileType java   nnoremap <buffer> <f5> :w<cr> :exec "w !javac % && java Car" <cr>
autocmd VimEnter * exec "so $MYVIMRC"
"cmd history nav
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
"rerender window with cleaning highlight search
nnoremap <c-l> :nohl<cr><c-l>
"quickfix list
nnoremap <silent> [e :cp<CR>
nnoremap <silent> ]e :cn<CR>
"buffers
nnoremap <silent> <C-j> :bnext<CR>
nnoremap <silent> <C-k> :bprevious<CR>
"save buffer
noremap <Leader>w :w!<CR>
"revert buffer
noremap <silent><Leader>! :e!<CR>
"delete buffer without closing window
nnoremap <Leader>c :bp<bar>sp<bar>bn<bar>bd!<CR>
"delete buffer with closing window
nnoremap <silent> <Leader>; :bd!<CR>
"only one window
nnoremap <Leader>o <C-w>o
"close window
nnoremap <Leader>q <C-w>q
"terminal
nnoremap <silent> <Leader>t :sp<CR>:term<CR>
"open netrw
noremap <Leader>e :e .<CR>
"save and source init.vim
noremap <Leader>v :w!<bar>:so %<CR>
"show registers
noremap <Leader>r :reg<CR>
"jumps between widnows
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"************************************************************************************************
"********************************************  SPECIAL  *****************************************
"************************************************************************************************
let g:molokai_original = 1
let g:material_terminal_italics = 1
let g:deoplete#enable_at_startup = 1
"gitgutter
let g:gitgutter_max_signs=9999
"Ack use ag
if executable('rg')
    let g:ackprg = 'rg --vimgrep'
endif
"vim-javascript flow
let g:javascript_plugin_flow = 1
"ALE
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_enabled = 0
let g:ale_linters = {
            \   'jsx': ['eslint', 'flow'],
            \   'javascript': ['eslint', 'flow']
            \}
let g:ale_lint_on_text_changed = 'never'
"buftabline
"let g:buftabline_indicators = 1
"LSP
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ 'ruby': ['solargraph', 'stdio'],
            \ }
"highlight yank
let g:highlightedyank_highlight_duration = 300
"************************************************************************************************
"***************************************  MAPPINGS SPECIAL  *************************************
"************************************************************************************************
nnoremap <silent> [a :ALEPreviousWrap<CR>
nnoremap <silent> ]a :ALENextWrap<CR>
"GIT
nnoremap <silent> <Leader>gs :Gstatus<CR>
"nnoremap <silent> <Leader>gc :Commits<CR>
nnoremap <silent> <Leader>gw :Gblame<CR>
"Git log
nnoremap <silent> <Leader>gl :Git log<CR>
"Git commit -m
noremap <Leader>gc :Git commit -m
"FZF
noremap <silent> <Leader>l :Buffers<CR>
nnoremap <c-p> :GFiles <cr>
"gundo
noremap <silent> <Leader>i :GundoToggle<CR>
"easymotion
map <Leader>f <Plug>(easymotion-bd-f)
"LSP
"nnoremap <Leader>lu :call LanguageClient#textDocument_references()<CR>
"nnoremap <Leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <Leader>m :call LanguageClient_contextMenu()<CR>
nnoremap <silent>K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent>gd :call LanguageClient#textDocument_definition()<CR>
"Emmet
let g:user_emmet_leader_key='<C-Z>'
