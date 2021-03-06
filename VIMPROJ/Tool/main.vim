"初始化CPP环境
source  $VIMPROJ/Tool/InitCPP.vim
"初始化LUA环境
source  $VIMPROJ/Tool/InitLua.vim
"初始化PKM环境
source  $VIMPROJ/Tool/InitPkm.vim
"初始化PHP环境
source  $VIMPROJ/Tool/InitPHP.vim
"初始化工作目录
source  $VIMPROJ/Tool/SwitchDir.vim

function! MaximizeWindow()    
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

function! SaveLatestModifyFileName(is_update)
    if(g:proj_type!="cpp" && g:proj_type!="php" && g:proj_type!="pkm")
        return
    endif

    if(a:is_update==1)
        let g:chiyl_last_modify_file_name=strpart(expand("%:p"),strlen(getcwd())+1)
    else
        call writefile([g:chiyl_last_modify_file_name], ".last_modify_file");
    endif
endfunction

function! OpenLatestModifyFile()
    "默认打开最近修改的文件
    let vim_proj=$VIMPROJ."/Tool"
    let cygwin_proj=$CYGWINPATH."/mintty.exe"
    call delete(".openfile.tmp")
    let a:tips="wait for update last modify file:.openfile.tmp "
    if(g:iswindows==1)
        let cmd= "! ".cygwin_proj." ".vim_proj."/get_the_latest_cppproj_modifty_file.sh"
        silent! execute cmd 

        while(!filereadable(".openfile.tmp"))
            echo a:tips
            let a:tips=a:tips."  .  "
            sleep 1
        endwhile

        source .openfile.tmp
    else
        let cmd= "!sh ".vim_proj."/get_the_latest_cppproj_modifty_file.sh"
        silent! execute cmd 
        while(!filereadable(".openfile.tmp"))
            echo a:tips
            let a:tips=a:tips."  .  "
            sleep 1
        endwhile
        source .openfile.tmp
    endif
endfunction


function! Main(pa)
        "最大化窗口
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

        "autocmd
        autocmd BufWritePost *	call SaveLatestModifyFileName(1)
        autocmd VimLeave *	call SaveLatestModifyFileName(0)

        if(has("gui_macvim"))    
            set fu
        endif
        silent execute "redraw"
endfunction

