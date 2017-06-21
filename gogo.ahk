#Persistent
global server_flag = False
global no_response_flag = False

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

refresh(id){
	WinActivate, %id%
	sleep,1000
	
	sleep, 500
	controlsend, ,{ESC}, %id%
	controlsend, ,{ESC}, %id%
	sleep, 500
	controlsend, ,s, %id%
	controlsend, ,s, %id%
	sleep, 500
	controlsend, ,{ctrl down}r, %id%
	controlsend, ,{ctrl up}, %id%
	sleep, 200
	controlsend, ,{ctrl down}r, %id%
	controlsend, ,{ctrl up}, %id%
	sleep, 500
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


start_winbaram(id, pw){
	msg = [+] START WINBARAM.EXE - %id%
	log(msg)
	ToolTip, %id% gogo, 0, 0 
	sleep, 200
	Run, "C:\Users\ur0n2\Desktop\123.lnk", , , pid1	
	Process, priority, %pid1%, High
	Winwait, Notice
	winmove Notice, , A_ScreenWidth/2, 0  ; for imagesearch. because notice window is upper than any windows
	sleep, 1000
	if (ErrorLevel != 0){
		msg = [-] IMAGE-SEARCH ERROR FROE NOTICE - %id%
		log(msg)
		return False
	}		
	msg = [+] START LOGIN - %id%
	log(msg)
	ImageSearch, fx,fy, 0,0 ,A_ScreenWidth, A_ScreenHeight, start.bmp
	;ImageSearch, fx, fy, 865, 649, 1142, 739, start.bmp

	if errorlevel = 0
	{
		mousemove, fx+25, fy+25
		mouseclick left, fx+25, fy+25, 2
		sleep, 5000 ;3000
		  
		  
		ImageSearch, fx,fy, 0,0 ,A_ScreenWidth, A_ScreenHeight, login1.bmp
		if errorlevel = 0
		{
		ToolTip, login1-sucess, 0, 0
		mousemove, fx+11, fy+11
		mouseclick left, fx+11, fy+11, 2
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
				return True				
			}
			else ;if errorlevel = 1
			{
				msg = [-] %id% - LOGIN3 FAIL
				log(msg)
				ToolTip, login3-error, 0, 0
				return False
			}
		}
		else ;if errorlevel = 1
		{
			ToolTip, login2-error, 0, 0
			msg = [-] %id% - LOGIN2 FAIL
			log(msg)
			return False
		}	
	  }
	  else ;if errorlevel = 1
	  {
		ToolTip, login1-error, 0, 0
		msg = [-] %id% - LOGIN1 FAIL
		log(msg)
		return False
	  }
	}
	else ;if errorlevel = 1 
	{
		ToolTip, start-error, 0, 0
		msg = [-] %id% - LOGIN START FAIL
		log(msg)
		return False
	}
	msg = [-] UNEXPECTED SITUATION - %id%
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
	server_reconn_check_result1 := server_reconn_check("카라")
	server_reconn_check_result2 := server_reconn_check("끄아")
	if (server_reconn_check_result1 || server_reconn_check_result2 ){
		global server_flag = True
		msg = [+] SERVER FLAG IN server_check_sub PROCEDURE: %server_flag%
		log(msg)
		msgbox, , , server is down, 1
		LOG("[-] SERVER IS DOWN... RESTART !")
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


go_training(id){
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


find_tree(id)
{
	;mousemove, 0, 0
	msg = [+] FIND TREE START - %id%
	log(msg)
	WinActivate, %id%
	sleep,1000
	controlsend, , n, %id% ; name remove
	;loop, 17
	;	controlsend, , {RIGHT} , %id% ; just for recoginize high probability. deprecate
	
	
	;find tree
	ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree.bmp
	if ErrorLevel != 0 
	{
		ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree1.bmp
		if ErrorLevel != 0 
		{
			ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree2.bmp
			if ErrorLevl != 0 
			{
				return False
			}
		}
	}
	
	
	;after find tree sucess
	if errorlevel = 0
	{
		mouseclick, left, fx+27, fy+40, 1
		sleep, 5000 ; go to the tree
		
		semicolon_check(id)
				
		ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight, corr2.bmp		
		if errorlevel = 0
		{
			return True
		}
		else
		{
			controlsend , , {DOWN}, %id% 
			semicolon_check(id)
		
			ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
			if errorlevel = 0
				return True
			else
			{
				controlsend , , {LEFT}, %id% 
				semicolon_check(id)
				ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
				if errorlevel = 0
					return True
				else
				{
					controlsend , , {UP}, %id% 
					semicolon_check(id)
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
					if errorlevel = 0
						return True
					else
					{
						controlsend , , {RIGHT}, %id% 
						semicolon_check(id)
					}
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
					if errorlevel = 0
						return True
					else
						return False
				}
			}
		}
	}	
	else
		return False
}



find_training(id){ ; up, down, left, right of character semicolon check
	;mousemove, 0, 0 ; no interrupt to imagesearch
	msg = [+] FIND TRAINING START - %id%
	log(msg)
	WinActivate, %id%
	sleep,1000
	
	ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *20 training.bmp
	if errorlevel = 0
	{
		mouseclick, left, fx+5, fy+25, 1
		sleep, 5000 ; move time
		
		semicolon_check(id)
		ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp ; training name list in status window
		if errorlevel = 0
			return True
		else{
			controlsend , , {DOWN}, %id% 
			semicolon_check(id)
		
			ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
			if errorlevel = 0
				return True
			else{
				controlsend , , {LEFT}, %id% 
				semicolon_check(id)
				ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
				if errorlevel = 0
					return True
				else{
					controlsend , , {UP}, %id% 
					semicolon_check(id)
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
					if errorlevel = 0
						return True
					else{
						controlsend , , {RIGHT}, %id% 
						semicolon_check(id)
					}
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
					if errorlevel = 0
						return True
					else
						return False
				}
			}
		}
	}	
	else
		return False
}

find_moksuNPC(id){
	WinActivate, %id%
	sleep,1000
	;win activate %id%
	ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight, moksuNPC.bmp
	if errorlevel = 0 
	{
		mouseclick, left, fx+5, fy+5, 3
		msg = [+] FIND MOKSU-NPC SUCCESS - %id%
		log(msg)
		return True
	}
	msg = [-] FIND MOKSU-NPC FAIL - %id%
	log(msg)
	return False
}


go_tree(id){
	WinActivate, %id%
	sleep,1000
	
	refresh(id)
	if ( A_WDay = 1 || A_WDay = 7 ){ ; weekend
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
/*
go_tree(id)
{
	WinActivate, %id%
	sleep,1000

	refresh(id)
	if ( A_WDay = 1 || A_WDay = 7 ){ ; weekend
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
			sleep, 1000
			controlsend, , {ENTER}, %id%  
			sleep, 500
			log("[+] GO TREE SUCCESS")
			return True
		}
	}
	else
	{ ; 평일
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
			log("[+] GO TREE SUCCESS")
				return True
			}
			else
				log("[-] GO TREE FAIL")
		}
	}

	log("[-] GO TREE FAIL")
	return False
}
*/

clean_process(){
	tooltip, clean_process, 0, 0
	loop, 6
		process, close, winbaram.exe
		
	send, #m
	send, #m
	
	log("[+] CLEAN PROCESS COMPLETE")
	return True
}


init_start(id1, id2){ 
	log("[+] INIT START")
	;msgbox, , %id1%
	ToolTip, start-winbaram, 0, 0
	send, #m
	start1 := start_winbaram(id1, "123123")
	msgbox, , ,%start1%, 2
	sleep, 5000
	WinWait, %id1%, , 60
	start2 := start_winbaram(id2, "123123")
	WinWait, %id2%, , 60
	start:= start1 && start2 ; AND Operation
	return start
}


;main
main(id1, id2)
{
	log("[+] MAIN START")
	MouseMove, 0, 0 ; for notice button. chang the image at on focus 
	ToolTip, start-macro, 0, 0
	playing = true ; deprecate
	
	init_start_result := init_start(id1, id2)
	msg = [+] init_start_result: %init_start_result%
	log(msg)
	
	if ( init_start_result := False ){
		log("[-] INIT START ERROR")
		ToolTip, start_winbaram-error, 0, 0
		return False ;clean()
	}
	else if ( init_start_result := True ){
		log("[+] START WINBARAM SUCCESS")
		ToolTip, start_winbaram-success, 0, 0
		go_training_status := go_training(id1)
		log("[+] GO TRAINING")
		go_tree_status := go_tree(id2)
		log("[+] GO TREE")
		if (go_training_status is True ){	
			log("[+] GO TRAINING SCENARIO START")
			loop, 6 { ; scenario 1
				find_training_status := find_training(id1)
				if (find_training_status ){
					log("[+] FIND TRAINING SUCCESS !")
					break
				}
				log("[-] FIND TRAINING FAIL RE-TRY")
				go_training_status := go_training(id1)
			}
		}
		
		if (go_tree_status is True){
			log("[+] GO TREE SCENARIO START")
			loop, 11 { ; scenario 1
				find_tree_status := find_tree(id2)
				if (find_tree_status ){
					log("[+] FIND TREE SUCCESS !")
					break
				}
				log("[-] FIND TREE FAIL RE-TRY")
				go_tree_status := go_tree(id2)
			}
		}
		if ( find_training_status && find_tree_status) {
			while True{
				log("[+] HIT START")
				hit_result := hit(id1,id2)
				if (hit_result is False){
					log("[-] HIT ERROR")
					return	
				}
			}
		}
		else{
			log("[+] MAIN ERROR")
			return
		}
	}
}



F1:: 
	log("[+] START FB MACRO")
	log("[+] START SETTIMER FOR SERVER STATUS")
	
	settimer, server_check_sub, 300000 ;5m
	;settimer, check_the_no_response, 300000 ;5m
	log("[+] SETTIMER ON")
	while true{	
		if (clean_process()){
			log("[+] CLEAN PROCESS COMPLETE")
			;log(server_flag)
			if (server_flag){
				log("[+] SERVER DISCONNECTION... ")
				msgbox , , , server_flag and timer reset, 1
				settimer, server_check_sub, off
				log("[-] SETTIMER OFF")
				global server_flag = false
				msg = [+] SERVER FLAG INITALIZE IN WHILE %server_flag%
				log(msg)
				;goto F1
			}	
			else
				log("[+] SERVER STATUS IS CLEAN")
			main_result := main("카라", "끄아") ; send 다 아디로 
			if (main_result = False)
				goto F1
		}
		log("[+] WAIT FOR SERVER REBOOT")
		sleep, 15000 ; 15s server reboot time
	}


F2::
	ToolTip, end-macro, 0, 0
	playing = false
	ExitApp	

F3::

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
