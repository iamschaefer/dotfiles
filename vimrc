if has('win32')
  set shell=powershell
  set shellcmdflag=-command
  behave mswin
  source $VIMRUNTIME/mswin.vim
end

if has('win32')
  if filewritable(expand("~/vimfiles/tmp-backup")) != 2
    call mkdir(expand("~/vimfiles/tmp-backup"))
    set backupdir=$HOME/vimfiles/backup
    set directory=$HOME/vimfiles/backup
  endif
else
  if filewritable(expand("~/.vim/tmp-backup")) != 2
    call mkdir(expand("~/.vim/tmp-backup"))
    set backupdir=$HOME/.vim/backup
    set directory=$HOME/.vim/backup
  endif
endif

call pathogen#infect()

set nocompatible
set hidden
set lines=60 columns=125
" always show tab bar at top
set showtabline=2
set history=10000
set winwidth=119
set number
set ruler
syntax on
filetype plugin indent on
set wildmenu
" only one space when joining spaces that have a .
set nojoinspaces
set scrolloff=5         " 3 lines above/below cursor when scrolling
if has("gui_running")
  colors solarized
  set guifont=Consolas:h11:cANSI:qDRAFT
end

" Relative line numbers
set number relativenumber

let mapleader = ","

" Paste and yank with the clipboard
map <leader>Y "*y
map <leader>P "*p
map <leader>y "+y
map <leader>p "+p

"turn of higlights quickly
nmap <cr> :noh<cr>

" Easy editing of vimrc
nmap <leader>v :edit $MYVIMRC<CR>

set guioptions-=T  " no toolbar
set guioptions-=m  "remove menu bar

nnoremap <C-s> :w<cr>

augroup vimrcEx
  autocmd!
  autocmd bufwritepost _vimrc source $MYVIMRC
  "autocmd bufwritepost .vimrc source $MYVIMRC
  "autocmd bufwritepost *vimrc source $MYVIMRC

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

" display incomplete commands
set showcmd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>


" ""
" "" Searching
" ""
"
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter


 " " Adjust viewports to the same size
map <Leader>= <C-w>=

set number            " Show line numbers
set ruler             " Show line and column number

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is four spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set autoindent
set autoread

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing
" whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is  off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is off and the line continues beyond the left of the screen

" 'stamp' word under cursor with yanked text, but don't replace text in yanked register
map <leader>st "_diwp

" find and replace word under cursor (complete word)
map <leader>sw :%s/\<<C-r><C-w>\>//g<Left><Left>

map <leader>a ggVG

" "
" "syntastic
" let g:syntastic_rust_checkers = ['rustc']
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:rustfmt_autosave = 1
"
"
" Tab completion
 set wildmode=list:longest,list:full
 set wildignore+=*.o,*.obj,.git,*.rbc
" Windows
set shell=powershell
set shellcmdflag=-command

" CtrlT config
"let g:ctrlp_map = <leader>t
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
end

