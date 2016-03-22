"��ʼ��CPP����
source  $VIMPROJ/Tool/InitCPP.vim
"��ʼ��LUA����
source  $VIMPROJ/Tool/InitLua.vim
"��ʼ��PKM����
source  $VIMPROJ/Tool/InitPkm.vim
"��ʼ��PHP����
source  $VIMPROJ/Tool/InitPHP.vim
"��ʼ������Ŀ¼
source  $VIMPROJ/Tool/SwitchDir.vim

function! MaximizeWindow()    
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

function! OpenLatestModifyFile()
    "Ĭ�ϴ�����޸ĵ��ļ�
    let vim_proj=$VIMPROJ."/Tool"
    let cygwin_proj=$CYGWINPATH."/mintty.exe"
    if(g:iswindows==1)
        let cmd= "! ".cygwin_proj." ".vim_proj."/get_the_latest_cppproj_modifty_file.sh"
        silent! execute cmd
        source ~openfile.tmp
    else
        let cmd= "!sh ".vim_proj."/get_the_latest_cppproj_modifty_file.sh"
        silent! execute cmd
        source .openfile.tmp
    endif
endfunction


function! Main(pa)
        "��󻯴���
        if (g:iswindows==1)
            :simalt ~x
        endif 

        let s:path=a:pa
        let s:filename=s:path
        call InitCPP()
        call InitLua()
        call InitPkm()
        call InitPHP()
        call SwitchDir(s:path)
        :silent! Tlist
        :NERDTree
        :set rnu
        call OpenLatestModifyFile()
        call InitWorkSpace()
        :set rnu
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
        else
            :echo call(function(g:chiylown_func_dict.getprojtypefunc("CSTAG")),[])
        endif

        if(has("gui_macvim"))    
            set fu
        endif
        silent execute "redraw"
endfunction

