:set spelllang=fr
:filetype plugin on
"let g:languagetool_jar='/home/hieu/.vim/LanguageTool-2.9/languagetool-commandline.jar'
let g:languagetool_jar='/home/hieu/.vim/LanguageTool-2.9/languagetool.jar'
"let g:languagetool_jar='$HOME/LanguageTool-2.9/languagetool-commandline.jar'
"let g:languagetool_jar=$HOME . '/lib/LanguageTool-2.9/languagetool-commandline.jar'
"let g:languagetool_jar=$HOME . '/lib/LanguageTool/LanguageTool.jar'

set t_Co=256
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
"autocmd FileType c,cpp source /home/llr/ilc/trant/.vim/after/syntax/opengl.vim

set nocompatible
set backspace=indent,eol,start
" set ic


"function! AdaptColorscheme()
"    highlight clear CursorLine
"    highlight Normal ctermbg=none
"    highlight LineNr ctermbg=none
"    highlight Folded ctermbg=none
"    highlight NonText ctermbg=none
"    highlight SpecialKey ctermbg=none
"    highlight VertSplit ctermbg=none
"    highlight SignColumn ctermbg=none
"endfunction
"autocmd ColorScheme * call AdaptColorscheme()
syntax on
"colorscheme blackboard
highlight NonText ctermbg=none
highlight Normal ctermbg=Black ctermfg=White
hi Normal ctermbg=NONE
"abbreviation definitions

"some C++ statements
ab #b /************************************
ab #e <space> *************************************/
ab #z /*****************************************************************************/
ab #x ###############################################################################
ab #p #------------------------------------------
ab #h <><CR></>
ab #i #include <>
ab #d #define 
ab uns using namespace std;

ab iif if ()<CR>{<CR>}
ab ifor for (;;)<CR>{<CR>}

ab pymain if __name__=="__main__": <CR> main() <CR>
ab bcm <!--
ab ecm -->

ab #c int main(int argc, char *argv[])
ab flt Float_t
ab framegr TH2F *frame = new TH2F("frame","",100,100,50000,100,0,2);
ab cht Char_t
ab dbt Double_t
ab tcanvas TCanvas *can = new TCanvas("canvas","canvas",800,600);<CR>can->cd();<CR>
ab vtfl vector<float>

ab parname <parameter name="" value =""/>
ab procn <processor name=""/>


" doesn't work iab ipython
" doesn't work \<CR>#!/usr/bin/python
" doesn't work \<CR>
" doesn't work \<CR>import os, sys, os.path

abbr ipython #!/usr/bin/python <CR><CR>import os, sys, os.path <CR>

abbr jpython #!/usr/bin/python <CR><CR>from __future__ import division<CR><CR>import os, sys, os.path<CR>import random, math<CR>import matplotlib.pyplot as plt<CR>from collections import defaultdict<CR><CR>

"#!/usr/bin/python 
"
"from __future__ import division
"
"import os, sys, os.path
"import random
"import math
"import matplotlib.pyplot as plt


" vimdiff color scheme
"highlight DiffChange cterm=none ctermfg=black ctermbg=LightGreen gui=none guifg=bg guibg=LightGreen
"highlight DiffText cterm=none ctermfg=black ctermbg=Yellow gui=none guifg=bg guibg=Yellow

set background=dark
"colorscheme base16-default
colorscheme blackboard
"colors wombat256mod
"colors tir_black

"colorscheme codeschool
"colors codeschool
"colors wombat
"colors desert
"colors xoria256

"color rdark
"colors freya
"colors hickop
"NO colors autumnleaf_modified
"olors kingtop
"colors herokudoc
"colors jellybeans
"colors desertEx
"colors wf

"highlight Normal ctermfg=grey ctermbg=blue
"highlight Normal guibg=black guifg=white
"set background=dark



"syntax enable
"highlight Normal guifg=White guibg=#0B1022 ctermfg=15 ctermbg=232
"set background=dark
"let g:solarized_termcolors=256
"colors solarized

"" white background: stupid color when using vimdiff
"if &diff
"    colorscheme github
"endif

set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"set autoindent          " always set autoindenting on
if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler    
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

"*****************************************
"*****************************************
if has('autocmd')
        " when event "set filetype" occurs (see :help filetype)
        autocmd Filetype perl call PerlDetected()
endif

"Hieu
autocmd Filetype tex set tw=80
"map some useful hotkeys
" map=Normal mode+Visual mode+Operator-pending mode
"<F12> to switch between windows
map <F12> <C-W>w
"<F2> to increase window width, <F3> to decrease
map <F2> <C-W>>
map <F3> <C-W><
"<F10> to increase window height, <F11> to decrease
map <F10> <C-W>+
map <F11> <C-W>-


"----------mapping my insert commands-----------
"----------i called them ";-command" 'cause you've the least hesitation
" between you type the ";" and the following <Space> or <CR>

"<;a> for Auto-completion using dictionary
imap ;a <C-X><C-K>
"then use <C-N> to match the next keywords, and <C-P> the previous one
" map!=imap+cmap (i=insert mode, c=:command mode)
" a) imap <Space><Space> xx also can work, but not good
" b) i cannot map <M-x> or <M-Space>, why?
" c) Ctrl-Space <=> Ctrl-@

" <F5> ================= set filetype to perl (Filetype event occurs)
" To see what is "set fo=", exec :help formatoptions
" This line of commands first disable to auto insert "comment leader (#)", then 
" use ":set comments" command to see the comment-leaders for such file
map <F5> :set fo-=r<CR>i#!/usr/bin/perl -w<CR><CR>#$Id$<CR><CR><Esc>:set filetyp

func PerlDetected()
        "<F4> == see perldoc for current word under cursor
        map <F4> :call PerlDoc(expand("<cword>"))<CR>

        "<F7> for perl debugging
        map <F7> :w<CR>:!perl -wd "%"<CR>
        "<F8> for perl syntax checking (autosave first)
        map <F8> :w<CR>:!perl -wc "%"<CR>
        "<F9> to run by perl (autosave first) "",'' are both ok
        map <F9> :w<CR>:!perl '%'<CR>
        " set dictionary for perl keywords completion
        set dictionary=$HOME/.perl.dictionary

        "set autoindent depth
        "set shiftwidth=4 ---commented 12/10/07
        "set tabstop
        "set tabstop=4    ---commented 12/10/07

        "when write buffer, set it executable
        "autocmd does not need the <CR>!!!
        autocmd BufUnload * call SetPerlExecutable()
endfunc

func SetPerlExecutable()
        if synIDattr(synID(1,1,1),"name")=="perlSharpBang"
                exec ':!(if [ \! -x '.expand("<afile>").' ]; then chmod +x '.exp
        endif
endfunc

func PerlDoc(keyword)
        if a:keyword=~"::"
                "module name;
                exec ':!perldoc '.a:keyword
        elseif a:keyword=~"^perl"
                "perl pod
                exec ':!perldoc '.a:keyword
        else
                "perl function
                exec ':!perldoc -f '.a:keyword
        endif
endfunc


" HIEU, 09/11.30 set cindent
set cindent
"set smartindent
set autoindent

let _curfile = expand("%s:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
  set tabstop=3
  set noexpandtab
else
  set expandtab
  set tabstop=3
  set shiftwidth=3
endif


"set cinkeys=0{,0},:,0#,!,!^F


set ruler
set backup
filetype on    
set bs=2

"set term=ansi
":fixdel
set backspace=2
" set the X11 font to use
"set guifontset=-*-*-bold-r-normal--20-*-*-*-*-*-*-*
set guifontset=-adobe-helvetica-bold-r-normal--*-120-*-*-*-*-iso*-*
set ch=2                " Make command line two lines high
"set nopaste
"set mouse=ra
"set mousehide		" Hide the mouse when typing text

set pastetoggle=<F2>

" Make shift-insert work like in Xterm
"map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

nnoremap <F8> :setl noai nocin nosi inde=<CR>

if version >= 500

  let c_comment_strings=1

" if !exists("syntax_on")
"   syntax on
" endif
endif
  set hlsearch


command Hi hi Normal ctermbg=none
autocmd VimEnter * Hi
