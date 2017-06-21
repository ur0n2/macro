
/*
*.txt���� Ȯ�� == n
����?50kb�� ���� ������ n�� ���� 
�α����� ũ�Ⱑ 400kb�� ���� ������ n���� log.txt�� ����
400kb�� ������ n+1�� ����
*/

;log_init
log_files_count(Directory)
{			
	log_count = 0
	Loop, %Directory%\*.txt
	{
		log_count := log_count + 1 
	}
	return log_count
}

log_init() {
	global log_dir
	FileCreateDir, log
	log_dir_path  = .\\log ; relative path
	log_count := log_files_count(log_dir_path)
	msgbox, , , log file count: %log_count%, 1
	if (log_count <= 0){		
		last_log_file = %log_dir_path%\\log%log_count%.txt ;.\\log\\log{n}.txt
	}
	else {
		;log files counting for last log file to append.
		last_log_file = %log_dir_path%\\log%log_count%.txt ;.\\log\\log{n}.txt
		msgbox, , , last log file: %last_log_file%, 1
	}
	;get last log file size
	FileGetSize, last_log_file_size, %last_log_file%, K
	if (!last_log_file_size) { ; first log file create
		last_log_file = %log_dir_path%\\log1.txt 		
	}
	msgbox, , , last log file size: %last_log_file_size%, 1


	;last log file size check. and log_dir variable set
	if (last_log_file_size >= 400) { ; if above 400KB then, create to new last log file
		num := log_count +1	
		log_dir = log\log%num%.txt	
	}
	else { ; if <400KB then, maintain present log file
		log_dir = log\log%log_count%.txt
		;msgbox, , , %log_dir%
	}
	
}

log(sentence) {
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%] %sentence%`n, %log_dir%
}

F1::
log_init()
loop, 10 {
	msg = asfasf
	log(msg)
}
	
F2::
	ExitApp


