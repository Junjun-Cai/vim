"����ļ���ͼʹ�ô��� VIM ��Ŀ���Ӽ򵥷��㡣
"�ٳ��õ�ȫ�������Ѿ��� _vimrc��������
"�ڳ��õ�CPP������InitCPP.vim������
"�ۻ���һЩÿ����Ŀ˽�е����ã�����˵��Ŀ�ĸ�Ŀ¼������ʱ��Ҫ�򿪵��ļ���һ���ϴ���Ŀ¼���õ�
"�ۡ���Ŀ��˽������������ļ��������á�
"

"��ʼ��Main����
source  $VIMPROJ/Tool/main.vim

function! InitWorkSpace()
	normal /\v<Game>
	normal o
	normal /MahjongGB
	normal o
	normal /GameTable-gb.cpp
	normal o
	:set rnu
    "let g:proj_type="cpp"
    "let g:proj_type="pkm"
    "let g:proj_type="php"

	let g:SSHRemoteBaseDir="/usr/server/Mahjong.gb/Borrow/Compile"
	let g:SSHUSER="lawrenceChi@192.168.200.144"
	let g:SSHPORT=3600
endfunction

"Main�����еĲ�������Ŀ���ڵĸ�Ŀ¼
call Main("$YourProject_ROOTDIR/")

