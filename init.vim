" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

set hidden
set updatetime=100
set shortmess+=c
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
let g:mapleader=","

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
" trigger coc completion
inoremap <silent><expr> <c-o> coc#refresh()

nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" show file explorer
nmap <space>e :CocCommand explorer<CR>
" 搜索文件
nnoremap <silent> <space>f :Files<CR>
nnoremap <silent> <space>b :Buffers<CR>
nnoremap <silent> <space>h :History<CR>
" 展開tag列表
nnoremap <silent> <space>t :TagbarOpenAutoClose<CR>
set nu
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set encoding=UTF-8

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

call plug#begin('~/.config/nvim/plugged')
" Use release branch (recommend)
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf'
Plug 'ryanoasis/vim-devicons'
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
