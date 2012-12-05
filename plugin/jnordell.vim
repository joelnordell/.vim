if ! has("gui_running")
  set t_Co=256
endif
set background=dark
colors peaksea

set mouse=a
set hlsearch
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" CTRL-X, CTRL-C, CTRL-V for Cut, Copy, Paste
vnoremap <C-X> "+x
vnoremap <C-C> "+y
map <C-V>   	"+gP
cmap <C-V>  	<C-R>+

" CTRL-S for Save
map <C-S> "+w

" CTRL-Z for Undo
map <C-Z> "+undo
map <C-Y> "+redo

" Set Left & Right to wrap around lines
set ww+=<,>,[,]
set ve=onemore

:highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
:match ExtraWhitespace /\s\+$/

" XCode-style auto-indentation
map <Tab> "+=l
" the following isn't quite working properly just yet
" imap <Tab> <Esc>:norm mz<CR>=l:norm `z<CR>li
set shiftwidth=2
set expandtab
set softtabstop=2
if has("autocmd")
  filetype plugin indent on
endif

" Shift-arrows to select
nmap <S-Up> vk
nmap <S-Down> vj
nmap <S-Left> vh
nmap <S-Right> vl
vmap <S-Up> k
vmap <S-Down> j
vmap <S-Left> h
vmap <S-Right> l

" autocmd VimEnter * NERDTree | wincmd p

set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set laststatus=2

" Status line - changes colors depending on insert mode
hi StatusLine     guifg=#666666   guibg=#1b1b1b   gui=none  ctermfg=245 ctermbg=236
hi StatusLineNC   guifg=#444444   guibg=#1b1b1b   gui=none  ctermfg=239 ctermbg=235
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guifg=#DA4939   guibg=#1b1b1b   gui=none  ctermfg=167 ctermbg=236
  elseif a:mode == 'r'
    hi statusline guifg=#0b0b0b   guibg=#DA4939   gui=none  ctermfg=236 ctermbg=167
  else
    hi statusline guifg=#666666   guibg=#1b1b1b   gui=none  ctermfg=245 ctermbg=236
  endif
endfunction
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline    guifg=#666666   guibg=#1b1b1b   gui=none  ctermfg=245 ctermbg=236

au filetype cucumber setlocal mp=bundle\ exec\ cucumber\ -c\ -f\ pretty\ %

set scrolloff=5

