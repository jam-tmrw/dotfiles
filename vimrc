" Leader
let mapleader = " "


map <Leader>i mmgg=G`m<CR>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
" linebreak with indent
imap <C-Return> <CR><CR><C-o>k<S-s> with <S-s>

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase    "don't use case
set smartcase     "recognize case if I use capitals in search
set laststatus=2  " Always display the status line
set clipboard+=unnamedplus
set breakindent

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set background=dark
  colorscheme solarized
endif

" enable AutoSave on Vim startup
let g:auto_save = 1

" do not save while in insert mode
let g:auto_save_in_insert_mode = 0

" airline tabs
let g:airline#extensions#tabline#enabled = 1

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" fugitive/Git
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gaa :Git add -A<CR><CR>
nnoremap <space>gu :Git reset %<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>

" Neomake config
autocmd BufWritePost,BufEnter * Neomake
let g:neomake_error_sign = {
      \ 'text': '>>',
      \ 'texthl': 'ErrorMsg',
      \ }
hi MyWarningMsg ctermbg=3 ctermfg=0
let g:neomake_warning_sign = {
      \ 'text': '>>',
      \ 'texthl': 'MyWarningMsg',
      \ }
" lint window
map <Leader>lo :lopen<CR>
map <Leader>lc :lclose<CR>

" go to dotfiles/vimrc/bundle
map <Leader>d :e  ~/dotfiles<CR>
map <Leader>vi :e  ~/dotfiles/vimrc<CR>
map <Leader>vb :e  ~/dotfiles/vimrc.bundles<CR>
map <Leader>vr :so ~/dotfiles/vimrc<CR>

" app navigation
map <Leader>vh :e ~/Desktop/webpass<CR>

" go to task lists
map <Leader>vp :e  ~/Dropbox/personal.md<CR>
map <Leader>vw :e  ~/Dropbox/work.md<CR>

" markdown
let g:vim_markdown_folding_disabled = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" airline fonts
let g:airline_powerline_fonts = 1

" don't index when I'm outside of project
let g:ctrlp_working_path_mode = '0'

" PyMatcher for CtrlP
if !has('python')
  echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
"
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 1

  "exclude files and directories from ctrlp etc
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" search buffers with ctrl-p
map <Leader>b :CtrlPBuffer<CR>
" clear cache
map <Leader>cc :CtrlPClearCache<CR>

" bind K to grep word under cursor or visually selected text
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
vnoremap K y :grep! <C-R>"<CR>:cw<CR>

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

" Make it obvious where 80 characters is
" set textwidth=80
" set colorcolumn=+1

" Numbers
set numberwidth=5
set number

" add space before and after in normal mode
nnoremap [s i<space><ESC>
nnoremap ]s a<space><ESC>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>tc :!ctags -R .<CR>

" easy replace all in file
map <Leader>ra :%s/

" easy replace all in file
map <Leader>r :s/

" find and replace selected word
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" quick save
nnoremap <C-s> :w<CR>

" quick close buffer
nnoremap <C-q> :bd<CR>

" quick close other windows
nnoremap <Leader>o :only<CR>

" Edit another file in the same directory as the current file (from
" github/r00k)
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" remove last search highlighting
nnoremap <Leader>h :noh<CR>

" tab completion
let g:deoplete#sources#syntax#min_keyword_length = 2
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"

" snippets
map <Leader>sn :UltiSnipsEdit!<CR>
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" new terminal
nnoremap <Leader>tn :Tnew<CR>
" terminal command
nnoremap <Leader>c :T<SPACE>
" goto terminal prompt
nnoremap <Leader>ti :Topen<CR><bar><C-w>j<bar><C-w>j<bar>i
" toggle terminal window
nnoremap <Leader>tt :Ttoggle<cr>
" clear terminal
nnoremap <Leader>tk :call neoterm#kill()<cr>

" run set test lib
let g:neoterm_npm_lib_cmd = 'spring teaspoon'
nnoremap <Leader>rt :call neoterm#test#run('all')<cr>
nnoremap <Leader>rf :call neoterm#test#run('file')<cr>
nnoremap <Leader>rn :call neoterm#test#run('current')<cr>
nnoremap <Leader>rr :call neoterm#test#rerun()<cr>

if has('nvim') && exists(':tnoremap')
  tnoremap <c-k> <C-\><C-n><bar>:Tclose<CR>
  tnoremap <c-o> <C-\><C-n><c-w>k
  tnoremap <c-v> <C-\><C-n><c-w>
  tnoremap <c-w>j <c-\><c-n><c-w>j
  tnoremap <c-w>k <c-\><c-n><c-w>k
  tnoremap <c-w>h <c-\><c-n><c-w>h
  tnoremap <c-w>l <c-\><c-n><c-w>l
  tnoremap <c-r> <c-\><c-n>"*pi
endif

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
