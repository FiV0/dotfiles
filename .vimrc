"Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'SirVer/ultisnips'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'slime/slime'
"Plugin 'l04m33/vlime', {'rtp': 'vim/'}
Plugin 'kovisoft/slimv'
Plugin 'kovisoft/paredit'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tpope/vim-surround'
Plugin 'flazz/vim-colorschemes'
"Plugin 'tpope/vim-fireplace'
Plugin 'elzr/vim-json'
"javascript indentation
"Plugin 'lukaszb/vim-web-indent'
Plugin 'othree/yajs.vim'
"Plugin 'marijnh/tern_for_vim'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'

"custom vim commands
set number
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set autochdir
set shell=/bin/sh
set backspace=indent,eol,start
set splitbelow
set splitright
" for squashed lines
set linespace=6
set formatoptions=cr
syntax on

"menu
set wildmenu
set wildmode=full
"source $VIRRUNTIME/menu.vim



map <A-Left> :tabprevious<CR>
map <A-Right> :tabnext<CR>
map <A-Up> :tabnew<CR>
map <A-Down> :q<CR>
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :vsp<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
""noremap <C-w> <C-w>w
"inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

"leader
let mapleader = ','
let maplocalleader = '.'

"syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_highlighting = 1
"let g:syntastic_enable_signs        = 1
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
"let g:syntastic_cpp_compiler_options = ' echo | clang -std=c++11 -stdlib=libc++ -v -E -x c++ -'
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args = '-E'

"Lisp stuff
"
"Slime
let g:slime_target = "screen"
"slimv
let g:slimv_repl_split=4
"let g:slimv_repl_split_size=20
"let g:slimv_swank_cmd = '! xterm -e sbcl --load /home/fv/.vim/bundle/slime/start-swank.lisp &'
"let g:slimv_menu = 1
let g:paredit_electric_return=0
"vlime
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {
      \ 'repl': {
        \ 'size' : 25
      \ },
      \ 'sldb': {
        \ 'pos': 'belowright',
      \ },
      \ 'inspector': {
        \ 'pos': 'belowright',
        \ 'vertical': v:true
      \ },
      \ 'preview': {
        \ 'pos': 'belowright',
        \ 'size': v:null,
        \ 'vertical': v:true
      \ }
    \ }
"vlime has it's on identation
"autocmd BufRead,BufNewFile *.lisp filetype indent off
autocmd FileType lisp set colorcolumn=80
"slimv usual mapped interrupt does not work
autocmd FileType lisp noremap ,z :call SlimvInterrupt()<CR>
"slimv to reopen repl buffer in new tab
autocmd FileType lisp noremap ,2 :call SlimvOpenBuffer('REPL')<CR>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,gradle,javascript let b:comment_leader = '// '
autocmd FileType sh,ruby,python          let b:comment_leader = '# '
" autocmd FileType conf,fstab       let b:comment_leader = '# '
" autocmd FileType tex              let b:comment_leader = '% '
" autocmd FileType mail             let b:comment_leader = '> '
" autocmd FileType vim              let b:comment_leader = '" '
autocmd filetype lisp,clojure            let b:comment_leader = ';; '
if !exists("b:comment_leader")
  noremap <silent> \c :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
  noremap <silent> \C :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
endif


"syntax checking wiht YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python'
"let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = "✗"
let g:ycm_warning_symbol = "⚠"
let g:ycm_filetype_blacklist = { 'lisp': 1 }
map <leader>o :lopen<CR>
map <leader>c :lclose<CR>
map <leader>j :lnext<CR>
map <leader>k :lprevious<CR>

" compiling
autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ -std=c++0x -O2 '.shellescape('%').' -o '.shellescape('%:r').' <CR>
autocmd filetype cpp nnoremap <F5> :w <bar> exec '!g++ -std=c++0x -g '.shellescape('%').' -o a.out' <CR><CR>

"python spaces
autocmd filetype python set tabstop=4|set shiftwidth=4|set expandtab|set cindent
"au BufNewFile,BufRead *.py
"     set tabstop=4
"     set softtabstop=4
"     set shiftwidth=4
"     set textwidth=79
"     set expandtab
"     set autoindent
"     set fileformat=unix

"Lisp
"function RemoveLeadingWhitespaces( c )
"  if a:c == ')'
"
"  endif
"endfunction
"
"autocmd filetype lisp nnoremap <leader>) :call RemoveLeadingWhitespaces(matchstr(getline('.'), '\%' . col('.') . 'c.')) <CR>

"Clojure
"let g:slimv_swank_clojure = '! xterm -e lein swank &'
"let g:slimv_disable_clojure = 1

"OCaml
"VimShell for OCaml
"open shell
map <C-o> :VimShellInteractive<CR><ESC><C-w>w
"send line
map <leader>s :VimShellSendString<CR>
"send paragraph
map <leader>p vip<leader>s<CR><ESC>
"send full file
map <leader>f 1GVG<leader>s <CR>
"get type of elem undor cursor currently not working
"map <leader>t :TypeOf<CR>

"eclim
"let g:EclimCompletionMethod = 'omnifunc'
"let g:EclimLogLevel = 'error'

"merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/merlin/vimbufsync"

"eliom
au BufEnter *.eliom set ft=ocaml

"merlin with Syntastic
"autocmd filetype ocaml let g:syntastic_ocaml_checkers = ['merlin']
au BufEnter *.ml,*.mli let g:syntastic_ocaml_checkers = ['merlin']

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'ocaml': { 'left': '(*','right': '*)' }, 'eliom': { 'left': '(*','right': '*)' } }

"ocp-indent-vim
au BufEnter *.ml,*.mli setf ocaml
set rtp+=~/.vim/bundle/ocp-indent-vim
autocmd filetype ocaml set expandtab
autocmd filetype ocaml nnoremap <F4> :w <bar> exec '!ocamlbuild -use-ocamlfind -no-hygiene '.shellescape('%:r').'.native' <CR><CR>
autocmd filetype ocaml call FT_ocaml()
function FT_ocaml()
    "set textwidth=80
    set colorcolumn=80
    set shiftwidth=2
    set tabstop=2
    " ocp-indent with ocp-indent-vim
    let opamshare=system("opam config var share | tr -d '\n'")
    execute "autocmd FileType ocaml source".opamshare."/ocp-indent/vim/indent/ocaml.vim"
    filetype indent on
    filetype plugin indent on
endfunction

"colorscheme
colorscheme 256-jungle

"set tags=./tags;/
"set splitright
"
""auto update for ctags
"function! DelTagOfFile(file)
"  let fullpath = a:file
"  let cwd = getcwd()
"  let tagfilename = cwd . "/tags"
"  let f = substitute(fullpath, cwd . "/", "", "")
"  let f = escape(f, './')
"  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
"  let resp = system(cmd)
"endfunction
"
"function! UpdateTags()
"  let f = expand("%:p")
"  let cwd = getcwd()
"  let tagfilename = cwd . "/tags"
"  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
"  call DelTagOfFile(f)
"  let resp = system(cmd)
"endfunction
"autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()
"
""NeoBundle Scripts-----------------------------
"if has('vim_starting')
"  set nocompatible               " Be iMproved
"
"  " Required:
"  set runtimepath+=/home/fv/.vim/bundle/neobundle.vim/
"endif
"
"" Required:
"call neobundle#begin(expand('/home/fv/.vim/bundle'))
"
"" Let NeoBundle manage NeoBundle
"" Required:
"NeoBundleFetch 'Shougo/neobundle.vim'
"
"" Add or remove your Bundles here:
"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'
"
"" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimproc.vim', {
"	      \ 'build' : {
"	      \     'windows' : 'tools\\update-dll-mingw',
"	      \     'cygwin' : 'make -f make_cygwin.mak',
"	      \     'mac' : 'make -f make_mac.mak',
"	      \     'unix' : 'make -f make_unix.mak',
"	      \    },
"	      \ }
"NeoBundle 'Shougo/vimshell'
"
"
"" Required:
"call neobundle#end()
"
"
"" If there are uninstalled bundles found on startup,
"" this will conveniently prompt you to install them.
"NeoBundleCheck
""End NeoBundle Scripts-------------------------
