"����ļ���ͼʹ�ô��� VIM ��Ŀ���Ӽ򵥷��㡣
"�ٳ��õ�ȫ�������Ѿ��� _vimrc��������
"�ڳ��õ�CPP������InitCPP.vim������
"�ۻ���һЩÿ����Ŀ˽�е����ã�����˵��Ŀ�ĸ�Ŀ¼������ʱ��Ҫ�򿪵��ļ���һ���ϴ���Ŀ¼���õ�
"�ۡ���Ŀ��˽������������ļ��������á�
"

"��ʼ��Main����
source  $VIMPROJ/Tool/main.vim

function! InitWorkSpace()
	normal /Game
	normal o
	normal /MahjongGB
	normal o
	normal /GameTable-gb.cpp
	normal o
	:set rnu
    "let g:proj_type="cpp"
    "let g:proj_type="pkm"
    "let g:proj_type="php"

	let g:SSHSendDir="/"
	let g:SSHUSER="chiyl@192.168.199.1"
	let g:SSHPORT=3600
	let g:SSHRemoteDir="/usr/server/EventMonitor/"

	"let g:SSHSendDir="/"
	"let g:SSHUSER="lawrenceChi@192.168.200.1"
	"let g:SSHPORT=3600
	"let g:SSHRemoteDir="/usr/server/EventMonitor/"
endfunction

"Main�����еĲ�������Ŀ���ڵĸ�Ŀ¼
call Main("$YourProject_ROOTDIR/")

