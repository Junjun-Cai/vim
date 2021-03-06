"函数
function UPFILE_cpp()
    let choice=confirm("Upload file?", "&modefy\n&All\n&Cancel",1)
    if (choice!=3)
        let vim_proj=$VIMPROJ."/Tool"
        if(g:iswindows==1)
            let cygwin_proj=$CYGWINPATH."/mintty.exe"
        else
            let cygwin_proj='bash'
        endif
        if(g:SSHRemoteBaseDir!="")
            let cmd= "! ".cygwin_proj." ".vim_proj."/cpp_getmodifyfile_and_upload.sh ".g:SSHUSER." ".g:SSHPORT." ".g:SSHRemoteBaseDir." ".choice
            if(g:iswindows==1)
                silent execute cmd
            else
                execute cmd
            endif
        endif
    endif
endfunction

function CSTAG_cpp()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.hpp,*.java,*.cs,*.hxx,*.cxx,*.cc | findstr /v \"cpp~\" >> cscope.files"
        endif
        silent! execute "!cscope -b"
        silent! execute "normal :"
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
        endif
    endif
endfunction

function ASTYLE_cpp()
    let g:astyle_file=expand("%")
    silent execute "!astyle -A1M40Sjk1n --mode=c ".getcwd()."/".g:astyle_file
endfunction

function! InitCPP()
    " OmniCppComplete
    let g:OmniCpp_NamespaceSearch = 1 " 1 = search namespaces in the current buffer
    let g:OmniCpp_GlobalScopeSearch = 1 "enabled Global scope search toggle
    let g:OmniCpp_ShowAccess = 1  "enable to show the access information ('+', '#', '-') in the popup menu.
    let g:OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
    let g:OmniCpp_MayCompleteDot = 1 " autocomplete after .
    let g:OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
    let g:OmniCpp_MayCompleteScope = 1 " autocomplete after ::
    let g:OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
    " automatically open and close the popup menu / preview window
    "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    "set completeopt=menuone,menu,longest,preview
    "预览窗口不会自动关闭 by LawrenceChi
    set completeopt=menuone,menu,longest,preview
    if(g:iswindows==1)
        :set tags+=$VIMPROJ/vimlib/cppstl/tags,$VIMPROJ/vimlib/linux/tags,$VIMPROJ/vimlib/zeromq-3.2.5/tags
    else
        :set tags+=$VIMPROJ/vimlib/cppstl/tags,$VIMPROJ/vimlib/linux/tags.linux,$VIMPROJ/vimlib/zeromq-3.2.5/tags.linux
    endif
    
    :set path+=$VIMPROJ/vimlib/cppstl/cpp_src,$VIMPROJ/vimlib/linux/include,$VIMPROJ/vimlib/linux/include/sys/,$VIMPROJ/vimlib/zeromq-3.2.5/include
    let g:chiylown_func_dict["UPFILE"]["cpp"]="UPFILE_cpp"
    let g:chiylown_func_dict["CSTAG"]["cpp"]="CSTAG_cpp"
    let g:chiylown_func_dict["ASTYLE"]["cpp"]="ASTYLE_cpp"
endfunction

