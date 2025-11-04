" Enable vim-plug
call plug#begin('~/.vim/plugged')

" GitHub Copilot
Plug 'github/copilot.vim'

" Markdown Preview
Plug 'iamcco/markdown-preview.vim'

call plug#end()

" Optional Copilot configuration
let g:copilot_filetypes = {
    \ '*': v:false,
    \ 'rust': v:true,
    \ 'python': v:true,
    \ 'javascript': v:true,
    \ 'typescript': v:true,
    \ 'go': v:true,
    \ 'cpp': v:true,
    \ 'c': v:true,
    \ 'java': v:true,
    \ }

" Tab to accept suggestions
imap <silent><script><expr> <Tab> copilot#Accept("\<Tab>")
let g:copilot_no_tab_map = v:true

" Use § key to dismiss Copilot suggestions
imap <silent> § <Cmd>call copilot#Dismiss()<CR>

" Optional: Show copilot status in statusline
set statusline=%{copilot#Statusline()}

