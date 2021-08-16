" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" 快捷鍵映射
" <space>a 對代碼塊執行可選的操作
" <space>b 顯示當前buffer中的文件列表
" <space>e 展示當前目錄下的文件列表
" <space>f 在預設的路徑下使用fzf查找文件
" <space>h 展示歷史文件列表
" <space>t 展示當前文件的tag列表
" <space> - 在代碼語法錯誤之間跳轉 prev
" <space> = 在代碼語法錯誤之間跳轉 next
" gd       跳轉到定義
" gy       跳轉到變量類型的定義
" gi       跳轉到實現
" gr       跳轉到引用
" ctrl-o   插入模式下觸發代碼補全
" ctrl-o   普通模式下往回跳轉
" shift-N  切换到下一个buffer
" shift-P  切换到上一个buffer
" shift-B  构建CMake项目
" shift-C  配置CMake项目
" shift-E  编辑CMake配置文件
" shift-R  运行可执行文件
" shift-X  关闭当前buffer
" <F7>     打开终端
" <F8>     上一个终端
" <F9>     下一个终端
" <F10>    关闭当前终端
" <F12>    在编辑器和终端之间进行切换
" <space>ci 单独切换每个行的注释状态 
" <space>cm 多行注释
" <space>cu 取消多行注释

" set hidden
set updatetime=100
set shortmess+=c
set nu
set smarttab
set ts=4
set softtabstop=4
set expandtab
set autoindent
set shiftwidth=4
set encoding=UTF-8

let g:mapleader="\<space>"

" 将所有的json文件看作是jsonc文件，以支持注释
augroup JsonToJsonc
    autocmd! FileType json set filetype=jsonc
augroup END

"tab補全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 觸發代碼補全
inoremap <silent><expr> <c-o> coc#refresh()
" 在代碼的錯誤之間跳轉
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" GoTo code navigation. ctrl-o返回
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 對鼠標當前指向的變量或函數名及其引用高亮
autocmd CursorHold * silent call CocActionAsync('highlight')
" 對選中的區域進行一些操作，比如將選中的代碼塊提取成爲一個單獨的函數
xmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-selected)
" 展示文件瀏覽器
nmap <space>e :CocCommand explorer<CR>
" 搜索文件
nnoremap <silent> <space>f :Files<CR>
nnoremap <silent> <space>b :Buffers<CR>
nnoremap <silent> <space>h :History<CR>
" 展開tag列表
nnoremap <silent> <space>t :TagbarOpenAutoClose<CR>
" 在任何時候打開init.vim
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
" 運行異步任務
noremap <silent><S-R> :AsyncTask file-run<cr>
noremap <silent><S-B> :AsyncTask file-build<cr>
noremap <silent><S-C> :AsyncTask file-configure<cr>
noremap <silent><S-E> :AsyncTaskEdit<cr>
" AirLine 切换 buffer
nnoremap <S-N> :bn<CR>
nnoremap <S-P> :bp<CR>
nnoremap <S-X> :bdelete<CR>
" Floaterm配置
let g:floaterm_autohide      = 0
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_kill   = '<F10>'
let g:floaterm_keymap_toggle = '<F12>'
" nerdcommenter配置
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


call plug#begin('~/.config/nvim/plugged')
" Use release branch (recommend)
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'preservim/tagbar'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
Plug 'sickill/vim-monokai'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdcommenter'
Plug 'puremourning/vimspector'
call plug#end()

syntax enable
colorscheme monokai

let g:coc_global_extensions = [
        \ 'coc-json', 
        \ 'coc-yaml', 
        \ 'coc-vimlsp', 
        \ 'coc-cmake',
        \ 'coc-explorer',
        \ 'coc-tsserver',
        \ 'coc-java']
let g:rainbow_active = 1
let g:asyncrun_open = 10
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:vimspector_enable_mappings = 'HUMAN'

set cursorline
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
set mouse=a

let g:vimspector_terminal_maxheight = 10

function! s:CustomiseUI()
  " Close the output window
  call win_gotoid( g:vimspector_session_windows.output )
  q
endfunction

augroup MyVimspectorUICustomistaion
  autocmd!
  autocmd User VimspectorUICreated call s:CustomiseUI()
augroup END

sign define vimspectorBP            text=🔴 texthl=LineNr
sign define vimspectorBPCond        text=🔵 texthl=LineNr
sign define vimspectorBPDisabled    text=🟠 texthl=LineNr
sign define vimspectorPC            text=⏩ texthl=LineNr
sign define vimspectorPCBP          text=⏭ texthl=LineNr
sign define vimspectorCurrentThread text=▶  texthl=LineNr
sign define vimspectorCurrentFrame  text=▶  texthl=LineNr
