" ---- USER CONFIG ----

" UTF-8
set encoding=utf-8

" 1 tab == 4 spaces, with intelligent indenting
set shiftwidth=4
set tabstop=4
set expandtab
set cinkeys-=:

" Don't fold anything
set nofoldenable

" Setting vertical line
set colorcolumn=79
highlight ColorColumn ctermbg=236

" Special colors
highlight NormalFloat ctermbg=237
highlight Pmenu ctermbg=237 ctermfg=255
highlight SpellBad ctermfg=black
highlight SpellLocal ctermfg=black

" Sets how many lines of history VIM has to remember
set history=500

" Shows the line count on the left
set number
highlight LineNr ctermfg=darkgrey

" System clipboard by default. Doesn't clear the clipboard when closing vim
set clipboard=unnamedplus
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Open :Term below
set splitbelow

" ---- COMMANDS ----

command Quickhelp :silent !firefox https://github.com/marioortizmanero/dotfiles/blob/master/README.md
command Copydir :let @+ = expand("%:p:h")
command Term :split | resize 13 | term
command SpellCheck :set spell spelllang=en_us


" ---- BINDINGS ----

" Stop search highlighting with esc
nnoremap <silent><CR> :noh<CR><CR>
" Open current location in new window with ls
nnoremap + :silent exec "!kitty --directory" expand('%:p:h') "sh -c 'ls; zsh' &"<CR>
" Disable shift+arrow because it's easy to mistype it
noremap <S-Up> <Up>
noremap <S-Down> <Down>
noremap <S-Left> <Left>
noremap <S-Right> <Right>
" Quick terminal command
noremap ,t :Term<CR>
" Quick refresh command
noremap ,r :edit<CR>
" Exit terminal insert mode with Esc
tnoremap <Esc> <C-\><C-n>
" Indentation type toggle
noremap ,i :exec TabToggle()<CR>
function TabToggle()
  if &expandtab
    set shiftwidth=4
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endif
endfunction
" Toggle for showing numbers
noremap ,n :set nu!<CR>
" Showing the colorcolumn at 120 characters
noremap ,l :set colorcolumn=120<CR>
" Make shortcuts
noremap ,m :make<CR>


" ---- PLUGINS ----

" Coc-nvim: only show with <tab>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
     \ pumvisible() ? "\<C-n>" :
     \ <SID>check_back_space() ? "\<Tab>" :
     \ coc#refresh()

" Plug: plugin manager
call plug#begin('~/.vim/plugged')

" coc.nvim: autocompletion
" plug-ins: coc-python, coc-css, coc-json, coc-html, coc-phpls
" linters: ccls (AUR)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vim-gitgutter: git diff symbols to the left
Plug 'airblade/vim-gitgutter'
" lightline: improved status bar
Plug 'itchyny/lightline.vim'
" vim-grip: live markdown preview
Plug 'PratikBhusal/vim-grip'
" nerdcommenter: comment and uncomment easily
Plug 'scrooloose/nerdcommenter'
" nerdtree: file manager
Plug 'scrooloose/nerdtree'

call plug#end()

" NERDCommenter
let NERDSpaceDelims=1
noremap ,c :call NERDComment(0,'Toggle')<CR>

" Lightline
set noshowmode
set laststatus=2

" GitGutter
set updatetime=300

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
    \ if (argc() == 0 && !exists("s:std_in")) || isdirectory(expand('%'))
        \ | NERDTree |
    \ endif
let NERDTreeShowHidden=1
let NERDTreeWinSize=25
