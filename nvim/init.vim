scriptencoding utf-8
"
"  _   _         __     ___
" | \ | | ___  __\ \   / (_)_ __ ___
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"
"
" Basic Options
set fileformat=unix

" Abbreviaton
abbr slef self
abbr cosntants constants
abbr unkown unknown
abbr clas class
abbr krags kwargs
abbr __clas__ __class__

" Misc
set clipboard+=unnamedplus
set cursorline
set mouse=a
set nofoldenable
set nopaste
set noshowmode
set noswapfile
set nowrap
set path+=**
set scrolloff=3
set signcolumn=yes
set splitright splitbelow
set timeoutlen=400
set ttyfast
set updatetime=100
set termguicolors

" Tab magic
set expandtab
set shiftround
set smartindent
set smarttab
set softtabstop
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Searching
set ignorecase " Case insensitive search
set smartcase " case-sensitive if the expression contains a capital Letter
set hlsearch " Highlight search results
set incsearch " Set incremental search
set nolazyredraw " Do not redraw while executing macros

" Show invisible characters
set list listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮ showbreak=↪

" Configuration Group
augroup ConfigGroup
    autocmd!
    " Save on focus lost
    autocmd FocusLost * silent! wa!
    " Set Filetypes
    autocmd BufRead,BufNewFile *.har set filetype=json
    autocmd FileType yaml,javascript,json,html,jinja.html,toml setlocal sw=2 ts=2 sts=2
    autocmd Filetype gitcommit,md,tex,txt setlocal spell
augroup END

" Mappings
let mapleader = ','

" Save files and stuff
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wqa!<CR>
nnoremap <leader>e :wq!<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>Q :qa!<CR>

" Tabs, source and no highlight
nnoremap <leader>R :source $MYVIMRC<CR>
nnoremap <silent> <space> :noh<CR>

" make ^, 0 and $ work like you expect
nnoremap <silent> ^ g^
nnoremap <silent> 0 g0
nnoremap <silent> $ g$

" Portview scroll faster
nnoremap <silent> <C-e> 3<c-e>
nnoremap <silent> <C-y> 3<c-y>

" Switch to last buffer
nnoremap <silent> <BS> <c-^>

" Keep in vsual mode after indentation
vmap <silent> < <gv
vmap <silent> > >gv

" More natural split navigation
nnoremap <C-l> <C-W>l
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h

" Terminal splitting
augroup terminalConfig
    au!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
augroup END

nnoremap <silent> <c-w>tv <c-w>v :term<CR>
nnoremap <silent> <c-w>ts <c-w>s :term<CR>
" Move from withing the terminal split
tnoremap <silent> <c-h> <c-\><c-n><c-w><c-h>
tnoremap <silent> <c-j> <c-\><c-n><c-w><c-j>
tnoremap <silent> <c-k> <c-\><c-n><c-w><c-k>
tnoremap <silent> <c-l> <c-\><c-n><c-w><c-l>
tnoremap <silent> <ESC> <c-\><c-n>

" Options for vim-plug
let g:plug_pwindow = 'vertical rightbelow new'
let g:plug_timeout = 300

call plug#begin('$HOME/.local/share/nvim/plugged')

    " General plugins
    Plug 'arcticicestudio/nord-vim'
        let g:nord_cursor_line_number_background = 1
        let g:nord_uniform_diff_background = 1
        let g:nord_bold = 1 " Default
        let g:nord_italic = 1
        let g:nord_underline = 1

    " Lightline
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'
        let g:lightline = {
        \ 'colorscheme': 'nord',
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['gitbranch'],
        \     ['filename', 'modified', 'readonly'],
        \   ],
        \   'right': [
        \     ['linter_warnings', 'linter_errors'],
        \     ['filetype', 'fileformat', 'filenameencoding'],
        \     ['virtualenv'],
        \   ],
        \ },
        \ 'inactive': {
        \   'left': [
        \     [], [], ['filename'],
        \   ],
        \   'right': [
        \     [], [], ['filetype']
        \   ],
        \ },
        \ 'tabline': {
        \   'left': [ ['tabs'] ],
        \   'right': [],
        \ },
        \ 'tabs': {
        \   'active': ['filename', 'modified'],
        \   'inactive': ['filename', 'modified'],
        \ },
        \ 'component_function': {
        \   'gitbranch': 'FugitiveHead',
        \   'readonly': 'LightlineReadonly',
        \   'filenameencoding': 'LightlineFileEncoding',
        \   'fileformat': 'LightlineFileFormat',
        \   'filename': 'LightlineFileName',
        \   'virtualenv': 'poetv#statusline'
        \ }
        \ }

        let g:lightline.component_expand = {
        \ 'linter_warnings': 'lightline#ale#warnings',
        \ 'linter_errors': 'lightline#ale#errors',
        \ }

        let g:lightline#ale#indicator_warnings = '  '
        let g:lightline#ale#indicator_errors  = '  '

        let g:lightline.component_type = {
        \ 'linter_warnings': 'warning',
        \ 'linter_errors': 'error',
        \ }

        function! LightlineReadonly()
            " Check wether a file is readonly
            return &readonly && &filetype !=# 'help' ? 'RO' : ''
        endfunction

        function! LightlineFileEncoding()
            " Only return the file encoding if it's not utf-8
            return &fileencoding ==? 'utf-8' ? '' : &fileencoding
        endfunction

        function! LightlineFileFormat()
            " only show the file format if it's not 'unix'
            return &fileformat ==? 'unix' ? '' : &fileformat
        endfunction

        function! LightlineFileName() abort
            let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
            let modified = &modified ? ' +' : ''
            return fnamemodify(filename, ':~:.') . modified
        endfunction

    " Startify, alternative startup screen
    Plug 'mhinz/vim-startify'
        augroup startify
            autocmd User Startified setlocal cursorline
        augroup END

        " Don't change to directory when selecting a file
        let g:startify_files_number = 5
        let g:startify_change_to_dir = 0
        let g:startify_relative_path = 1
        let g:startify_use_env = 1
        let g:startify_padding_left = 4

        function! s:gitModified()
            let files = systemlist('git ls-files -m 2>/dev/null')
            return map(files, "{'line': v:val, 'path': v:val}")
        endfunction

        " same as above, but show untracked files, honouring .gitignore
        function! s:gitUntracked()
            let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
            return map(files, "{'line': v:val, 'path': v:val}")
        endfunction

        " Custom startup list, only show MRU from current directory/project
        let g:startify_lists = [
        \ { 'type': 'dir', 'header': ['    Files '. getcwd()] },
        \ { 'type': function('s:gitModified'),  'header': ['    Modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['    Untracked']},
        \ { 'type': 'sessions',  'header': ['    Sessions'] },
        \ { 'type': 'commands',  'header': ['    Plugins'] },
        \ ]

        let g:startify_commands = [
        \ { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
        \ { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
        \ { 'in': [ 'Install New Plugins', ':PlugInstall' ] },
        \ { 'cl': [ 'Cleanup untracker Plugins', ':PlugClean' ] },
        \ ]

    Plug 'dstein64/nvim-scrollview'
        let g:scrollview_on_startup = 1
        let g:scrollview_winblend = 25

    Plug 'farmergreg/vim-lastplace'

    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

    " FZF - The most important plugin
    Plug 'junegunn/fzf.vim'
        let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
        let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}

        augroup fzfconfig
            autocmd! FileType fzf
            autocmd  Filetype fzf set noshowmode noruler nonu
        augroup END

        if isdirectory('.git')
            nnoremap <leader>f :GitFiles --cache --others --exclude-standard<CR>
        else
            nnoremap <leader>f :FZF<CR>
        endif

        nnoremap <leader>b :Buffers<CR>
        nnoremap <leader>, :Rg<CR>
        nnoremap <leader>c :Commands<CR>

    Plug 'stsewd/fzf-checkout.vim'
        let g:fzf_checkout_git_options = '--sort=-committerdate'

    Plug 'mhinz/vim-signify'
    Plug 'rhysd/git-messenger.vim'
        let g:git_messenger_no_default_mappings = v:true
        let g:git_messenger_include_diff = 'current'
        let g:git_messenger_always_into_popup = v:true

    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
        map <leader>* :Ggrep --untracked <cword> <CR><CR>

        command Gl Git pull
        command Gp Git push
        command Gpf Git push --force-with-lease
        command Gca Git commit --amend
        command Grb Git rebase
        command Grbd Git rebase develop
        command Grbid Git rebase develop --interactive
        command Grbc Git rebase --continue
        command Gwip Git wip
        command Gsw GBranches
        command Gsta Git stash push
        command Gstp Git stash pop
        command Gstcl Git stash clear

    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'

    Plug 'chaoren/vim-wordmotion'

    Plug 'christoomey/vim-sort-motion'
        let g:sort_motion_flags = 'ui'

    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/rainbow_parentheses.vim'
        let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

        augroup rainbow
            autocmd!
            autocmd FileType * RainbowParentheses
        augroup END

    Plug 'junegunn/vim-peekaboo'
        let g:peekaboo_window = 'vert bo 60new'

    Plug 'junegunn/vim-slash'
        noremap <plug>(slash-after) zz
        if has('timers')
            " Blink 2 times with 50ms interval
            noremap <expr> <plug>(slash-after) 'zz'.slash#blink(3, 50)
        endif

    Plug 'dominikduda/vim_current_word'
        let g:vim_current_word#highlight_delay = 500

    " Completion stuff
    Plug  'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        let g:deoplete#enable_at_startup = 1

        " Completion selection candidates using TAB/S-TAB
        inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
        inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

        " Close preview window after completion
        augroup deopleteConfig
            autocmd!
            autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
        augroup END

    Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
        let g:deoplete#sources#jedi#enable_typeinfo = 0
        let g:deoplete#sources#jedi#show_docstring = 1
        let g:deoplete#source#jedi#ignore_errors = 1
        let g:deoplete#source#jedi#ignore_private_members = 1

    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
        let g:jedi#completions_enabled = 0
        let g:jedi#use_splits_not_buffers = 'winwidth'

    Plug 'deoplete-plugins/deoplete-zsh', { 'for': 'sh' }
    Plug 'deoplete-plugins/deoplete-docker', { 'for': 'Dockerfile' }
    Plug 'deoplete-plugins/deoplete-dictionary'
    Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rs' }

    " Linting
    Plug 'dense-analysis/ale'
        let g:airline#extensions#ale#enabled = 1

        let g:ale_echo_msg_format = '[%linter%]: %s'

        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_insert_leave = 0
        let g:ale_python_flake8_use_global = 1

        let g:ale_linters_explicit = 1
        let g:ale_linters = {
        \ 'css': ['stylelint'],
        \ 'json': ['jq'],
        \ 'python': ['flake8helled', 'flake8', 'vulture', 'mypy'],
        \ 'rust': ['rls'],
        \ 'sh': ['shellcheck'],
        \ 'sql': ['sqlint'],
        \ 'tex': ['lacheck'],
        \ 'vim': ['vint'],
        \ 'yaml': ['yamllint']
        \ }

        let g:ale_set_loclist = 1
        let g:ale_fix_on_save = 1

        let g:ale_fixers = {
        \ '*': ['trim_whitespace', 'remove_trailing_lines'],
        \ 'css': ['prettier'],
        \ 'javascript': ['prettier'],
        \ 'json': ['jq'],
        \ 'markdown': ['prettier'],
        \ 'python': ['isort', 'black'],
        \ 'rust': ['rustfmt'],
        \ 'yaml': ['prettier']
        \ }

        let g:ale_python_black_options = ''
        let g:ale_python_flake8_options = '--max-line-length $PYTHON_LINE_LENGTH'
        let g:ale_python_isort_options = ''
        let g:ale_python_mypy_options = '--config-file $DOTFILES/python/mypy.ini'
        let g:ale_python_vulture_options = '--min-confidence 100'

        nnoremap <silent> ]l :ALENextWrap<CR>
        nnoremap <silent> [l :ALEPreviousWrap<CR>

    " Docstring autoformatter
    function! <SID>format_docstrings()
        let l = line('.')
        let c = col('.')
        %!docformatter -c --wrap-summaries $PYTHON_LINE_LENGTH --wrap-descriptions $PYTHON_LINE_LENGTH -
        call cursor(l, c)
    endfun

    nnoremap <leader>DS :call <SID>format_docstrings()<CR>

    " Testing framework in vim
    Plug 'vim-test/vim-test'
        let test#enabled_runner = ['python#pytest']
        let test#strategy = 'vimux'
        let test#python#runner = 'pytest'
        let test#python#pytest#options = {
        \ 'nearest': '-lsxv --durations=3',
        \ 'file': '--forked -qk ""',
        \ 'suite': '--color yes -qk "" --forked -n 4'
        \ }

        nmap <leader>t :TestNearest<CR>

    " Django specific commands
    command! Runserver call VimuxRunCommand("clear; echo -e 'Starting local development server'; poetry run ./manage.py runserver")
    command! Makemigrations call VimuxRunCommand("clear; echo -e 'Making new migrations'; poetry run ./manage.py makemigrations")
    command! RunTests call VimuxRunCommand("clear; echo -e 'Running Django Test Suite'; pdj")
    command! RunLinter call VimuxRunCommand("clear; echo -e 'poetry run linter'; poetry run linter")

    " Python specific plugins
    Plug 'petobens/poet-v', { 'for': 'python' }
        let g:poetv_executables = ['poetry']
        let g:poetv_statusline_symbol = ''
        let g:poetv_set_environment = 1
        let g:poetv_auto_activate = 1

    " Language specific plugins
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
        let g:vim_markdown_folding_disabled = 1
        let g:vim_markdown_conceal = 0

    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown'}

    Plug 'lervag/vimtex', { 'for': 'tex' }
        let g:tex_flavor = 'latex'

    Plug 'christianrondeau/vim-base64'
    Plug 'cespare/vim-toml', { 'for': 'toml' }
    Plug 'alvan/vim-closetag'
        let g:closetag_close_shortcut = '<leader>>'

    Plug 'gregsexton/MatchTag'
    Plug 'ap/vim-css-color'
    Plug 'Glench/Vim-Jinja2-Syntax'
    Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

    " Only load these plugins when inside tmux"
    Plug 'christoomey/vim-tmux-navigator'
        let g:tmux_navigator_save_on_switch = 1
        let g:tmux_navigator_disable_when_zoomed = 1
        let g:tmux_navigator_no_mappings = 1

        nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
        nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'wellle/tmux-complete.vim'
    Plug 'benmills/vimux'

call plug#end() " Finished Initialising Plugins

" " nvim-treesitter configuration
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = {"python", "json", "yaml", "bash", "c", "html", "regex", "rst", "rust", "toml"},
"   highlight = {
"     enable = true,
"   },
"   highlight = {
"     enable = true,
"   },
"   indent = {
"     enable = true,
"   },
" }
" EOF

" " Set up folding
" set foldexpr=nvim_treesitter#foldexpr()
" set foldmethod=expr

" Set the colorscheme
set background=dark
colorscheme nord
