#Persistent

log_files_count(Directory)
{			
	log_count = 0
	Loop, %Directory%\*.txt
	{
		log_count := log_count + 1 
	}
	return log_count-1
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

refresh(id){
	WinActivate, %id%
	sleep,1000
	
	controlsend, ,{ESC}, %id%
	controlsend, ,{ESC}, %id%
	sleep, 200
	controlsend, ,s, %id%
	controlsend, ,s, %id%
	sleep, 200
	controlsend, ,{ctrl down}r, %id%
	controlsend, ,{ctrl up}, %id%
	sleep, 200
	controlsend, ,{ctrl down}r, %id%
	controlsend, ,{ctrl up}, %id%
	sleep,200
	msg = [+] %id% SCREEN REFRESH SUCCESS
	log(msg)
}


set_login(id, pw){ ; id list: kara, kka, vm1, vm2 
	WinActivate, %id%
	sleep,1000
	
	sleep, 500
	send, %id%
	sleep, 500
	send, {tab}
	sleep, 500
	send, %pw%
	sleep, 500
	send, {enter}			
	sleep, 5000 ;10000 ; login time
	tooltip, input_id_pw_success, 0, 0
}


winbaram_execution(id, pw){
	msg = [+] START WINBARAM.EXE - %id%
	log(msg)
	ToolTip, %id% gogo, 0, 0 
	sleep, 200
	Run, winbaram_path, , , pid1	
	Process, priority, %pid1%, High
	Winwait, Notice
	winmove Notice, , A_ScreenWidth/2, 0  ; for imagesearch. because notice window is upper than any windows
	sleep, 1000
	if (ErrorLevel != 0){
		msg = [-] IMAGE-SEARCH ERROR FROM NOTICE - %id%
		log(msg)
		return False
	}		
	msg = [+] START logIN - %id%
	log(msg)
	ImageSearch, fx,fy, 0,0 ,A_ScreenWidth, A_ScreenHeight, start.bmp
	;ImageSearch, fx, fy, 865, 649, 1142, 739, start.bmp

	if errorlevel = 0
	{
		;mousemove, fx+25, fy+25
		mouseclick left, fx+25, fy+25, 2
		mousemove, 10, 10 ; stabilized for difference to the resolution.
		sleep, 5000 ;3000
		  
		  
		ImageSearch, fx,fy, 0,0 ,A_ScreenWidth, A_ScreenHeight, login1.bmp
		if errorlevel = 0
		{
		ToolTip, login1-sucess, 0, 0
		;mousemove, fx+11, fy+11
		mouseclick left, fx+11, fy+11, 2
		mousemove, 10, 10 		
		sleep, 2000
		ImageSearch, fx,fy, 0,0 ,A_ScreenWidth, A_ScreenHeight, login2.bmp
		if errorlevel = 0
		{
			ToolTip, login2-success, 0, 0
			send, {a}
			sleep, 2000
			ImageSearch, fx,fy, 0,0 ,A_ScreenWidth, A_ScreenHeight, login3.bmp
			if errorlevel = 0
			{
				ToolTip, login3-success, 0, 0
				set_login(id, pw)
							
				WinSetTitle, 바람의 나라, , %id% 
				WinActivate, %id%
				sleep, 500
				winmove, %id%, , 0, 0
				msg = [+] %id% - LOGIN SUCCESS
				log(msg)
				gosub, server_check_sub ; first login and first check
				return True				
			}
			else ;if errorlevel = 1
			{
				msg = [-] %id% - logIN3 FAIL
				log(msg)
				ToolTip, login3-error, 0, 0
				return False
			}
		}
		else ;if errorlevel = 1
		{
			ToolTip, login2-error, 0, 0
			msg = [-] %id% - logIN2 FAIL
			log(msg)
			return False
		}	
	  }
	  else ;if errorlevel = 1
	  {
		ToolTip, login1-error, 0, 0
		msg = [-] %id% - logIN1 FAIL
		log(msg)
		return False
	  }
	}
	else ;if errorlevel = 1 
	{
		ToolTip, start-error, 0, 0
		msg = [-] %id% - logIN START FAIL
		log(msg)
		return False
	}
	msg = [-] UNEXPECTED SITUATION IN WINBARAM_EXECUTION FUNCTION- %id%
	log(msg)
	return False
}


semicolon_check(id){ ; with find_tree and find_training
	WinActivate, %id%
	sleep, 200
	refresh(id)
	loop, 30{
		ControlSend, , {;}, %id%
		sleep, 1
	}
	msg = [+] RECOGNIZE TO TARGET OBJECT FROM SEMICOLON - %id%
	log(msg)	
	return True
	; if namu~ return bulmok ; image search message
	; else if namu~ return training
	; else false
}


server_reconn_check(id){
	msg = [+] SERVER RECONNECTION AND NO-RESPONSE CHECK - %id%
	log(msg)
	WinActivate, %id%	
	sleep,1000
	ImageSearch, fx, fy, 0,0 , A_ScreenWidth, A_ScreenHeight, reconn.bmp
	if (errorlevel = 0) {
		tooltip, server_reconnection, 10, 10  ;msgbox, , , findit!
		msg = [-] SERVER DISCONNECDTION IMAGE FINDED - %id%
		log(msg)		
		return True
	}
	ImageSearch, fx, fy, 0,0 , A_ScreenWidth, A_ScreenHeight, no_response.bmp
	if (errorlevel = 0) {
		tooltip, server_reconnection, 10, 10  ;msgbox, , , findit!
		msg = [-] WINBARAM.EXE NO RESPONSE IMAGE FINDED - %id%
		log(msg)		
		return True
	}
	return False
}

server_check_sub:
	log("[+] SERVER CHECK SUB")
	server_reconn_check_result1 := server_reconn_check(id1)
	server_reconn_check_result2 := server_reconn_check(id2)
	if (server_reconn_check_result1 || server_reconn_check_rsesult2 ){
		global server_flag = True
		msg = [+] SERVER FLAG IN server_check_sub PROCEDURE: %server_flag%
		log(msg)
		msgbox, , , server is down, 1
		log("[-] SERVER IS DOWN... RESTART !")
		
		sleep, 15000 ; 15s server reboot time
		log("[+] WAIT FOR SERVER REBOOTING...")
		;settimer, server_check_sub, off
		;log("[-] SETTIMER OFF")
		goto F1
	}
	return


hit(id1, id2){
	WinActivate, %id1%
	sleep,1000
	refresh(id1)
	WinActivate, %id2%
	sleep,1000
	refresh(id2)
	; weather_off()
	sleep, 2000
	
	log("[+] HITTING... !")
	while True{
		controlsend, , {space}{space}{space}, %id1% ; need to test for effectiveness
		; sleep, 1 ; enough
		controlsend, , {space}{space}{space}, %id2% ; need to test for effectiveness
		sleep, 1 ; enough
	}
}


move_training_map(id){
	WinActivate, %id%
	sleep,1000
	refresh(id)
	if ( A_WDay = 1 || A_WDay = 7 ){ ; 1=sunday, 7=saturday
		controlsend, , {ctrl down}e{ctrl up}, %id%
		sleep, 500
		controlsend, , {up}{up}{ENTER}, %id%
		sleep, 500
		controlsend, , {RIGHT}{ENTER}, %id%
		sleep, 500
		ControlSend, , {RIGHT}{ENTER}, %id%
		sleep, 500
		msg = [+] GO TRAINING SUCCESS - %id%
		log(msg)
		return True ; no map name check
	}
	else{
		controlsend, , {ctrl down}e{ctrl up}, %id%
		sleep, 500
		controlsend, , {up}{up}{ENTER}, %id%
		sleep, 500
		controlsend, , {RIGHT}{ENTER}, %id%
		sleep, 500
		ControlSend, , {RIGHT}{ENTER}, %id%
		sleep, 500
		msg = [+] GO TRAINING SUCCESS - %id%
		log(msg)
		return True
	}
	
  
	return False ;return find_training()
}


find_tree_image(id)
{
	msg = [+] FIND TREE IMAGE START - %id%
	log(msg)
	WinActivate, %id%
	sleep,1000
	controlsend, , n, %id% ; name remove
	;loop, 17
	;	controlsend, , {RIGHT} , %id% ; just for recoginize high probability. deprecate
	; -> scenario... move coordinate or click move, etc...
	
	ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree.bmp
	if ErrorLevel != 0 
	{
		ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree1.bmp
		if ErrorLevel != 0 
		{
			ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree2.bmp
			if ErrorLevel != 0 
			{						
				msg = [+] FIND TREE IMAGE IS FAIL - %id%
				log(msg)
				return False
			}
		}
	}
	
	; 위아래양옆, corr$.bmp로 반복문 가능 
	;after find tree sucess
	if (errorlevel = 0) {
		msg = [+] FIND TREE IMAGE SUCCESS - %id%
		log(msg)
		mouseclick, left, fx+27, fy+40, 1
		mousemove, 10, 10 		
		sleep, 5000 ; go to the tree
		
		semicolon_check(id)		
		ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight, corr2.bmp		
		if errorlevel = 0 
		{
			msg = [+] TREE IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
			log(msg)
			return True
		}
		else
		{
			controlsend , , {DOWN}, %id% 
			semicolon_check(id)		
			ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
			if errorlevel = 0 
			{					
				msg = [+] TREE IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
				log(msg)
				return True
			}
			else
			{
				controlsend , , {LEFT}, %id% 
				semicolon_check(id)
				ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
				if errorlevel = 0 
				{					
					msg = [+] TREE IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
					log(msg)
					return True
				}
				else
				{
					controlsend , , {UP}, %id% 
					semicolon_check(id)
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
					if errorlevel = 0 
					{					
						msg = [+] TREE IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
						log(msg)
						return True
					}
					else
					{
						controlsend , , {RIGHT}, %id% 
						semicolon_check(id)
						ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
						if errorlevel = 0 
						{					
							msg = [+] TREE IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
							log(msg)
							return True
						}
						else {
							msg = [-] TREE IN FRONT OF U FAIL BY SEMICOLON CHECK - %id%
							log(msg)
							return False
						}
					}
				}
			}
		}
	}	
	else {	
		msg = [+] FIND TREE IMAGE IS FAIL - %id%
		log(msg)
		return False
	}
}



find_training_image(id){ ; up, down, left, right of character semicolon check
	;mousemove, 0, 0 ; no interrupt to imagesearch
	msg = [+] FIND TRAINING IMAGE START - %id%
	log(msg)
	WinActivate, %id%
	sleep,1000
	
	ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *20 training.bmp
	if errorlevel = 0
	{
		msg = [+] FIND TRAINING IMAGE SUCCESS - %id%
		log(msg)
		mouseclick, left, fx+5, fy+25, 1
		mousemove, 10, 10 
		sleep, 5000 ; move time
		
		semicolon_check(id)
		ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp ; training name list in status window
		if errorlevel = 0 
		{
			msg = [+] TRAINING IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
			log(msg)
			return True
		}
		else{
			controlsend , , {DOWN}, %id% 
			semicolon_check(id)
		
			ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
			if errorlevel = 0 
			{
				msg = [+] TRAINING IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
				log(msg)
				return True
			}
			else{
				controlsend , , {LEFT}, %id% 
				semicolon_check(id)
				ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
				if errorlevel = 0 
				{
					msg = [+] TRAINING IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
					log(msg)
					return True
				}
				else{
					controlsend , , {UP}, %id% 
					semicolon_check(id)
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
					if errorlevel = 0 
					{
						msg = [+] TRAINING IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
						log(msg)
						return True
					}
					else{
						controlsend , , {RIGHT}, %id% 
						semicolon_check(id)
					}
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
					if errorlevel = 0 
					{
						msg = [+] TRAINING IN FRONT OF U SUCCESS BY SEMICOLON CHECK - %id%
						log(msg)
						return True
					}
					else {
						msg = [-] TRAINING IN FRONT OF U FAIL BY SEMICOLON CHECK - %id%
						log(msg)
						return False
					}
				}
			}
		}
	}	
	else	{
		msg = [+] FIND TRAINING IMAGE IS FAIL - %id%
		log(msg)
		return False
	}
}

find_moksuNPC(id){
	WinActivate, %id%
	sleep,1000
	;win activate %id%
	ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight, moksuNPC.bmp
	if errorlevel = 0 
	{
		mouseclick, left, fx+5, fy+5, 3
		mousemove, 10, 10 
		msg = [+] FIND MOKSU-NPC SUCCESS - %id%
		log(msg)
		return True
	}
	msg = [-] FIND MOKSU-NPC FAIL - %id%
	log(msg)
	return False
}

move_tree_map(id){
	WinActivate, %id%
	sleep,1000
	
	refresh(id)
	if ( A_WDay = 1 || A_WDay = 7 ) { ; 주말
		controlsend, , uu, %id% 
		sleep, 500
		controlsend, , {DOWN}{DOWN}{DOWN}, %id%  
		sleep, 500
		controlsend, , {ENTER}, %id%  
		sleep, 500
		find_moksuNPC_result := find_moksuNPC(id)
		if (find_moksuNPC_result){
			sleep, 500
			controlsend, , {DOWN}, %id%  
			sleep, 500
			controlsend, , {ENTER}, %id%  
			sleep, 500
			return True
		}
	}
	else{ ; 평일
		controlsend, , uu, %id% 
		sleep, 500
		controlsend, , {DOWN}{DOWN}{DOWN}, %id%  
		sleep, 500
		controlsend, , {ENTER}, %id%  
		sleep, 500
		find_moksuNPC_result := find_moksuNPC(id)
		if (find_moksuNPC_result){
			sleep, 1000
			controlsend, , {DOWN}, %id%  
			sleep, 500
			controlsend, , {ENTER}, %id%  
			sleep, 500
			return True
		}
	}
	return False
}

clean_process(){
	tooltip, clean_process, 0, 0
	loop, 20{
		process, close, winbaram.exe
		sleep, 500
	}
	send, #m
	send, #m
	
	log("[+] CLEAN PROCESS COMPLETE")
	return True
}


winbaram_execution_loader(id1, id2){ 
	log("[+] WINBARAM EXEUCTION LOADER START")
	;msgbox, , %id1%
	ToolTip, start-winbaram, 0, 0
	send, #m
	
	winbaram_execution_result1 := winbaram_execution(id1,  id1_pw)
	msgbox, , ,%winbaram_execution_result1%, 2
	sleep, 5000 ; id1 login time?
	WinWait, %id1%, , 60
	
	winbaram_execution_result2 := winbaram_execution(id2, id2_pw)
	WinWait, %id2%, , 60
	
	winbaram_execution_result := winbaram_execution_result1 && winbaram_execution_result2 ; AND Operation
	return winbaram_execution_result
}


go_training_scenario(id) {
	log("[+] GO TRAINING SCENARIO START")
	loop, 6 { ; scenario 1
		find_training_image_status := find_training_image(id)
		if (find_training_image_status ){
			log("[+] FIND TRAINING IMAGE SUCCESS !")			
			return True
		}
		log("[-] FIND TRAINING IMAGE FAIL. RE-TRY")
	}
	return False
}

go_tree_scenario(id) {
	log("[+] GO TREE SCENARIO START")
	loop, 11 { ; scenario 1
		find_tree_image_status := find_tree_image(id)
		if (find_tree_image_status ){
			log("[+] FIND TREE IMAGE SUCCESS !")
			return True
		}
		log("[-] FIND TREE IMAGE FAIL. RE-TRY")		
	}
	return False
}

job_starter(id) {
	msg = [+] JOB START - %id%
	log(msg)
	
	if  (id_job = tree) {
		move_tree_map_status := move_tree_map(id)
		msg = [+] MOVE TREE MAP - %id%
		log(msg)
		if (move_tree_map_status) {
			msg = [+] GO TREE SCENARIO - %id%
			log(msg)
			go_tree_scenario_result := go_tree_scenario(id) ; i want to unconditional success.
			if (go_tree_scenario_result = True) {
				msg = [+] GO TREE SCENARIO SUCCESS
				log(msg)
				return True
			}
			else {
				msg = [-] GO TREE SCENARIO FAIL
				log(msg)
				return False
			}
		}
		else {
			msg = [-] MOVE TREE MAP STATUS IS FALSE - %id%
			log(msg)
			return False
		}
	}
	else { ;(id_job = training)
		move_training_map_status := move_training_map(id)
		msg = [+] MOVE TRAINING MAP - %id%
		log(msg)
		if (move_training_map_status = True) {
			msg = [+] GO TRAINING SCENARIO - %id%
			log(msg)
			go_training_scenario(id) ; i want to unconditional success.
			if (go_training_scenario_result = True) {
				msg = [+] GO TRAINING SCENARIO SUCCESS
				log(msg)
				return True
			}
			else {
				msg = [-] GO TRAINING SCENARIO FAIL
				log(msg)
				return False
			}
		}
		else {
			msg = [-] MOVE TRAINING MAP STATUS IS FALSE - %id%
			log(msg)
			return False
		}
	}
}


;main
main(id1, id2)
{
	log("[+] MAIN START")
	MouseMove, 0, 0 ; for notice button. chang the image at on focus 
	ToolTip, start-macro, 0, 0	
	
	winbaram_execution_loader_result := winbaram_execution_loader(id1, id2)
	msg = [+] winbaram_execution_loader_result: %winbaram_execution_loader_result%
	log(msg)
	
	if ( winbaram_execution_loader_result = False ){
		log("[-] WINBARAM EXEUCTION LOADER ERROR")
		ToolTip, winbaram_execution_loader error, 0, 0
		return False ;clean()
	}
	else if ( winbaram_execution_loader_result = True ){
		log("[+] WINBARAM EXECUTION LOADER SUCCESS")
		ToolTip, winbaram_execution_loader success, 0, 0
		
		job_starter_id1_result := job_starter(id1)
		job_starter_id2_result := job_starter(id2)
		
		if ( job_starter_id1_result && job_starter_id2_result) {
			;while True{ ; 있어야 하나?  
			;infinite loop in hit 
			log("[+] HIT START")
			hit_result := hit(id1,id2)
			if (hit_result = False){
				log("[-] HIT ERROR") ; do not raise this case
				return False
			}
			;}
		}
		else{
			log("[+] MAIN ERROR")
			return False
		}
	}
}

myip(){
	log("[+] GET MY IP")
	ip = %A_IPAddress1%
	return ip
}


id_pw_set(){
	ip := myip()
	
	if (ip = x.x.x.x){ ; lg
		id1 = 카라
		id1_pw = 123123
		id1_job = training
		id2 = 끄아
		id2_pw = 123123
		id2_job = tree
		winbaram_path =  C:\Users\ur0n2\Desktop\123.lnk
	}
	else if (ip = x.x.x.x){ ;nc
		id1 = 손나은
		id1_pw = apfhd12
		id1_job = tree
		id2 = 윤아
		id2_pw = apfhd12
		id2_job = tree
		winbaram_path = C:\Users\ur0n2\Desktop\123.lnk
	}
}

global playing = 1
global id1
global id1_pw
global id1_job
global id2
global id2_pw
global id2_job
global winbaram_path

F1:: 
	global server_flag = False
	global no_response_flag = False
	global playing := playing + 1
	
	log_init()
	ip := myip()
	msg = [+] START TO FB MACRO [%playing% DONE]- %ip%
	log(msg)
	
	id_pw_set()
	msg = [+] ID / PW SETTING
	log(msg)
	
	log("[+] START SETTIMER FOR SERVER STATUS")	
	settimer, server_check_sub, 300000 ; 5 minutes
	log("[+] SETTIMER ON")
	
	while true{	
		if (clean_process()){
			log("[+] CLEAN PROCESS COMPLETE")			
			if (server_flag){
				log("[+] SERVER DISCONNECTION... ")
				server_flag = False ; equally global server_flag = false				
				log("[+] SERVER FLAG RESET")				
			}	
			else
				log("[+] SERVER STATUS IS CLEAN") ;WINBARAM STATUS IS CLEAN

			main_result := main(id1, id2)
			
			if (main_result = False){
				log("[-] MAIN RESULT IS FALSE GOTO F1")
				goto F1
			}
		}		
	}


F2::
	ToolTip, end-macro, 0, 0
	msg = [+] END TO FB MACRO [%playing% DONE]- %ip%
	log(msg)
	ExitApp	

F3::
	Pause ; suspend
	
F4::
	Reload
	
	
go_smithy(){ ; 대장간
	;2 case. not needs. depracte
	
}

set_option(){ ; deprecate
	;옷벗기
	; 귓거부등 
		;날씨끄기 필수구나 
	;이름안보이기#ClipboardTimeo
	; 무기끼기#ClipboardTimeout
}

go_coordinate(wx, wy){
	;i go to for want coordinate
}


recognition_xy_coordinate(){
	; deprecate 
	; 최악의 경우 맵별로 좌표 따서 ... 이건 
	; 근데 이게 확실킨 하다#ClipboardT
	; 
}
