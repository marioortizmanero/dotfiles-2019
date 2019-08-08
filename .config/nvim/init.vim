" ---- USER CONFIG ----

" UTF-8
set encoding=utf-8

" 1 tab == 4 spaces, with intelligent indenting
set shiftwidth=4
set tabstop=4
set expandtab
set cinkeys-=:

" Setting vertical line
set colorcolumn=86
highlight ColorColumn ctermbg=236

" Floating windows and pmenu colors
highlight NormalFloat ctermbg=237
highlight Pmenu ctermbg=237 ctermfg=255

" Sets how many lines of history VIM has to remember
set history=500

" Shows the line count on the left
set number
highlight LineNr ctermfg=darkgrey

" System clipboard by default. Doesn't clear the clipboard when closing vim
set clipboard=unnamedplus
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Netrw: file manager
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_winsize = 15
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Vexplore | endif


" ---- COMMANDS ----

command Copydir :let @+ = expand("%:p:h")


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
" plug-ins: coc-python, coc-css, coc-json, coc-html
" linters: ccls (AUR)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vim-gitgutter: git diff symbols to the left
Plug 'airblade/vim-gitgutter'
" lightline: improved status bar
Plug 'itchyny/lightline.vim'
" vim-vinegar: improvements for netrw
Plug 'tpope/vim-vinegar'
" vim-grip: live markdown preview
Plug 'PratikBhusal/vim-grip'
" nerdcommenter: comment and uncomment easily
Plug 'scrooloose/nerdcommenter'

call plug#end()

" NERDCommenter
let NERDSpaceDelims=1
noremap ,c :call NERDComment(0,'Toggle')<CR>

" Lightline
set laststatus=2

" GitGutter
set updatetime=300

