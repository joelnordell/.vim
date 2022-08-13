" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ycm-core/YouCompleteMe'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'Shougo/context_filetype.vim'
Plug 'tyru/caw.vim'
Plug 'posva/vim-vue'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
Plug 'cespare/vim-toml'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'tpope/vim-unimpaired'
Plug 'hashivim/vim-terraform'
Plug 'lifepillar/pgsql.vim'
Plug 'ledger/vim-ledger'
if has('mac')
  Plug 'rizzatti/dash.vim'
endif
call plug#end()

" Faster help popups
set updatetime=1000

" Easier calling for :ALEFix prettier
command PrettierFix :ALEFix prettier

" Set ansible.yaml for known Ansible files
au BufRead,BufNewFile site.yml set filetype=yaml.ansible
au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible

" If others did not put newline at EOF, honor that decision.
set nofixendofline

" Prefer to treat .sql files as postgresql
let g:sql_type_default = 'pgsql'

" Set preferred behavior of backspace key
set backspace=indent,eol,start

" LSP for Terraform
let g:ycm_language_server = 
  \ [ 
  \   {
  \     'name': 'terraform',
  \     'cmdline': [ 'terraform-lsp' ],
  \     'filetypes': [ 'terraform' ]
  \   },
  \ ]

" Incremental search
set incsearch
" Use Tab/Shift-Tab to move between matches
" cmap <Tab> <C-g>
" cmap <S-Tab> <C-t>

" Resize panes like TMUX with Ctrl-Arrows (instead of Shift-Arrows)
" noremap <C-Up> :resize +1<CR>
" noremap <C-Down> :resize -1<CR>
" noremap <C-Left> :vertical:resize +1<CR>
" noremap <C-Right> :vertical:resize -1<CR>
let g:tmux_resizer_resize_count = 1
let g:tmux_resizer_vertical_resize_count = 1
nnoremap <silent> <C-D> :TmuxResizeDown<CR>
nnoremap <silent> <C-E> :TmuxResizeUp<CR>
nnoremap <silent> <C-G> :TmuxResizeLeft<CR>
nnoremap <silent> <C-H> :TmuxResizeRight<CR>

" easier to remember paragraph wrapping
function! WrapParagraph()
  exe "gqip"
endfunction

" open preview window on right hand side
" augroup previewWindowPosition
"   au!
"   autocmd BufWinEnter * call PreviewWindowPosition()
" augroup END
" function! PreviewWindowPosition()
"   if &previewwindow
"     wincmd L
"     vertical resize 65
"     set wm=2
"     set wrap linebreak
"     set nonu
"     set cc=
"     set foldcolumn=1
"   endif
" endfunction

" map turning off highlighting after search and closing quickfix window
nnoremap <Esc>/ :noh<CR>:ccl<CR>

" YouCompleteMe configuration
let g:ycm_clangd_binary_path = "/opt/clang/bin/clangd"
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']
let g:ycm_always_populate_location_list = 1
let g:ycm_add_preview_to_completeopt = 0

" Show completion detail in popup instead of preview (default was preview,menuone)
set completeopt=popup,menuone

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
if has('macunix')
  vnoremap <silent> <C-X> :!pbcopy<CR>gvx
  vnoremap <silent> <C-C> :!pbcopy<CR>u
  nnoremap <silent> <C-V> :-1r !pbpaste<CR>
elseif has('unix')
  vnoremap <silent> <C-X> :!xclip -f -sel clip<CR>gvx
  vnoremap <silent> <C-C> :!xclip -f -sel clip<CR>u
  nnoremap <silent> <C-V> :-1r !xclip -o -sel clip<CR>
endif

" Set vertical bar character to unicode box drawing char instead of pipe
set fillchars+=vert:│

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
let g:ctags_statusline=1

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
"vmap <silent> / :call NERDComment('nx', 'Toggle')<CR>
vmap <silent> / gcc

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
" highlight SpecialKey guibg=DarkMagenta ctermbg=DarkMagenta
au filetype * highlight Tabs guifg=#3B4252 term=bold ctermfg=236
au filetype * match Tabs /\t/

" highlight trailing whitespace

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

execute pathogen#infect()

" allow JSX for .js files
let g:jsx_ext_required = 0

" enable code folding based on syntax
"set foldmethod=syntax
"set nofoldenable

" Ctrl-] navigates using YCM
" nnoremap <C-]> :YcmCompleter GoToImprecise<cr>
nnoremap <C-]> :YcmCompleter GoToDefinition<cr>

""
" C++ IDE configuration
""

" Enable .vimrc in project directories
"if getcwd() =~ "^\($HOMEl/Projects/\)"
  "set secure exrc
"endif

" Map Ctrl-K to file quick-open using GFiles (unlike FZF it accounts for .gitignore)
function! GFilesOrFZF()
  if isdirectory(".git")
    :GFiles!
  else
    :FZF
  endif
endfunction
nnoremap <C-k> :call GFilesOrFZF()<CR>

" nnoremap <C-k> :FZF<CR>
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)


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

" Highlight whitespace errors
highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
hi! link ExtraWhitespace DiffRemoved
match ExtraWhitespace /\s\+$/
autocmd filetype * highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
autocmd filetype * hi! link ExtraWhitespace DiffRemoved

" Set fonts for MacVim
if has('mac') && has('gui_running')
  set macligatures
  set guifont=FiraCode-Retina:h12
endif
