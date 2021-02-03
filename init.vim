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
" <space>- 在代碼語法錯誤之間跳轉 prev
" <space>= 在代碼語法錯誤之間跳轉 next
" gd       跳轉到定義
" gy       跳轉到變量類型的定義
" gi       跳轉到實現
" gr       跳轉到引用
" ctrl-o   插入模式下觸發代碼補全
" ctrl-o   普通模式下往回跳轉


" set hidden
set updatetime=100
set shortmess+=c
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

let g:mapleader="\<space>"

" tab補全
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
noremap <silent><leader>tr :AsyncTask file-run<cr>
noremap <silent><leader>tb :AsyncTask file-build<cr>
noremap <silent><leader>tc :AsyncTask file-configure<cr>
noremap <silent><leader>te :AsyncTaskEdit<cr>

set nu
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set encoding=UTF-8

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
call plug#end()

let g:coc_global_extensions = [
        \ 'coc-json', 
        \ 'coc-yaml', 
        \ 'coc-vimlsp', 
        \ 'coc-cmake',
        \ 'coc-explorer']
let g:rainbow_active = 1
let g:asyncrun_open = 10
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
