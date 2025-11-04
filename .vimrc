"========================
" Plugins (vim-plug)
"========================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" GitHub Copilot
Plug 'github/copilot.vim'

" Markdown Preview
Plug 'iamcco/markdown-preview.vim'

call plug#end()

"========================
" GitHub Copilot configuration
"========================
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

" Tab to accept Copilot suggestions
imap <silent><script><expr> <Tab> copilot#Accept("\<Tab>")
let g:copilot_no_tab_map = v:true

" Use § key to dismiss Copilot suggestions
imap <silent> § <Cmd>call copilot#Dismiss()<CR>

" Optional: show Copilot status in the statusline
set statusline=%{copilot#Statusline()}

"========================
" Rainbow indentation (custom highlight blocks)
"========================
" Creates dark, transparent rainbow indent colors for tabs
function! RainbowIndent()
    highlight RainbowLevel1      ctermbg=24 guibg=#005f87   " dark blue
    highlight RainbowLevel2      ctermbg=28 guibg=#008700   " dark green
    highlight RainbowLevel3      ctermbg=90 guibg=#870087   " dark purple
    highlight RainbowLevel4      ctermbg=23 guibg=#005f5f   " dark cyan
    highlight RainbowLevel5      ctermbg=26 guibg=#005fd7   " medium blue
    highlight RainbowLevel6      ctermbg=29 guibg=#00875f   " teal

    highlight RainbowLevel7      ctermbg=24 guibg=#005f87   " dark blue
    highlight RainbowLevel8      ctermbg=28 guibg=#008700   " dark green
    highlight RainbowLevel9      ctermbg=90 guibg=#870087   " dark purple
    highlight RainbowLevel10     ctermbg=23 guibg=#005f5f   " dark cyan
    highlight RainbowLevel11     ctermbg=26 guibg=#005fd7   " medium blue
    highlight RainbowLevel12     ctermbg=29 guibg=#00875f   " teal

    " Match tab indentation depth
    syntax match RainbowLevel1   /^\t/
    syntax match RainbowLevel2   /^\t\t/
    syntax match RainbowLevel3   /^\t\t\t/
    syntax match RainbowLevel4   /^\t\t\t\t/
    syntax match RainbowLevel5   /^\t\t\t\t\t/
    syntax match RainbowLevel6   /^\t\t\t\t\t\t/
    syntax match RainbowLevel7   /^\t\t\t\t\t\t\t/
    syntax match RainbowLevel8   /^\t\t\t\t\t\t\t\t/
    syntax match RainbowLevel9   /^\t\t\t\t\t\t\t\t\t/
    syntax match RainbowLevel10  /^\t\t\t\t\t\t\t\t\t\t/
    syntax match RainbowLevel11  /^\t\t\t\t\t\t\t\t\t\t\t/
    syntax match RainbowLevel12  /^\t\t\t\t\t\t\t\t\t\t\t\t/
endfunction

" Apply the rainbow indent colors whenever a buffer is opened
autocmd BufEnter * call RainbowIndent()

"========================
" Indentation settings
"========================
" Tabs are actual tab characters (not spaces)
set noexpandtab

" Each tab = 4 spaces wide
set tabstop=4
set shiftwidth=4
set softtabstop=4
