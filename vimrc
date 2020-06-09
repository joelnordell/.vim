" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ycm-core/YouCompleteMe'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
call plug#end()

" YouCompleteMe configuration
let g:ycm_clangd_binary_path = "/opt/clang/bin/clangd"
let g:ycm_extra_conf_globlist = ['~/Projects/ErisExchangePricingEngine/*','!~/*','!*']

if ! has("gui_running")
  set t_Co=256
endif
"set background=dark
"colors peaksea
colorscheme nord

set mouse=a
set hlsearch
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" CTRL-X, CTRL-C, CTRL-V for Cut, Copy, Paste to XClipboard
"vnoremap <C-X> x
"vnoremap <C-C> y
"nnoremap <C-V> gP
vnoremap <silent> <C-X> :!xclip -f -sel clip<CR>gvx
vnoremap <silent> <C-C> :!xclip -f -sel clip<CR>u
nnoremap <silent> <C-V> :-1r !xclip -o -sel clip<CR>

"cmap <C-V>  <C-R>+

" CTRL-S for Save
nnoremap <C-S> :w<BR>

" CTRL-Z for Undo and CTRL-Y for Redo
" (Cannot map C-S-Z unfortunately)
map <C-Z> u
map <C-Y> :redo<CR>

" Q to quit
map Q :qa<CR>

" Set Left & Right to wrap around lines
set ww+=<,>,[,]
set ve=onemore

" Highlight whitespace errors
:highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
:match ExtraWhitespace /\s\+$/

" Map C-P to "goto newer" jumplist instead of C-I since we use Tab for indent
nnoremap <C-P> <C-I>

" XCode-style auto-indentation
map <Tab> ==
set shiftwidth=2
set expandtab
set softtabstop=2
if has("autocmd")
  filetype plugin indent on
  filetype plugin on
endif

" Shift-arrows to select
"nmap <S-Up> vk
"nmap <S-Down> vj
"nmap <S-Left> vh
"nmap <S-Right> vl
"vmap <S-Up> k
"vmap <S-Down> j
"vmap <S-Left> h
"vmap <S-Right> l

" autocmd VimEnter * NERDTree | wincmd p

set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set laststatus=2

" Status line - changes colors depending on insert mode
hi StatusLine     cterm=reverse guifg=#666666   guibg=#1b1b1b   gui=none  ctermfg=245 ctermbg=236
hi StatusLineNC   cterm=none    guifg=#444444   guibg=#1b1b1b   gui=none  ctermfg=239 ctermbg=235
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

" Better keybinding for NERDCommenter toggle
vmap <silent> / :call NERDComment('nx', 'Toggle')<CR>

" Allow ESC to cancel autocomplete popup
" (commented out for now, it's not working quite right)
"inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"

" Set nowrap with fancy indicator characters
set nowrap
"set listchars+=precedes:←,extends:→
set sidescroll=20
hi NonText     guifg=#ffffff

" Turn off annoying backup and swap files
set nobackup
set noswapfile

" Vertical line at 110 chars
hi Colorcolumn guibg=#32322f ctermbg=236
set colorcolumn=111

" CSV plugin default delimiters, to eliminate warning
let b:col='\%([^,]*,\|$\)'

" Make tabs visible
set list
set listchars=tab:\→\ 
highlight SpecialKey guibg=DarkMagenta ctermbg=DarkMagenta

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

execute pathogen#infect()

" allow JSX for .js files
let g:jsx_ext_required = 0

" enable code folding based on syntax
"set foldmethod=syntax
"set nofoldenable

" Ctrl-] navigates using YCM
nnoremap <C-]> :YcmCompleter GoToImprecise<cr>

""
" C++ IDE configuration
""

" Enable .vimrc in project directories
"if getcwd() =~ "^\($HOMEl/Projects/\)"
  "set secure exrc
"endif

" Map Ctrl-K to file quick-open using FZF
nnoremap <C-k> :FZF<CR>

""
" End C++ IDE configuration
""

"
" tmux-vim navigation integration -- trying to use control keys that are either unbound, or not
" used for anything I'd miss. These match to corresponding entries in .tmux.conf.local.
"
" Normally these bindings are as follows:
" C-a: UNBOUND
" C-b: back (up) one screen  (I use PgUp)
" C-f: foreward (down) one screen  (I use PgDn)
" C-n: move down one line  (I use arrow keys)
"
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_disable_when_zoomed = 1
noremap <silent> <C-a> :TmuxNavigateLeft<cr>
noremap <silent> <C-b> :TmuxNavigateDown<cr>
noremap <silent> <C-f> :TmuxNavigateUp<cr>
noremap <silent> <C-n> :TmuxNavigateRight<cr>
inoremap <C-a> <esc>:TmuxNavigateLeft<cr>
inoremap <C-b> <esc>:TmuxNavigateDown<cr>
inoremap <C-f> <esc>:TmuxNavigateUp<cr>
inoremap <C-n> <esc>:TmuxNavigateRight<cr>
noremap <silent> <C-\> :TmuxNavigatePrevious<cr>
