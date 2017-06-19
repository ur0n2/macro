#Persistent
global server_flag = False


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
	ToolTip, %id% gogo, 0, 0 
	sleep, 200
	
	Run, "C:\Users\ur0n2\Desktop\123.lnk", , , pid1	
	Process, priority, %pid1%, High
	Winwait, Notice
	sleep, 2000
	if (ErrorLevel != 0){
		msgbox % "error"
		return False
	}	
	;msgbox % pid1
	sleep, 2000


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
				return True
			}
			else if errorlevel = 1
			{
				ToolTip, login1-error, 0, 0
				return False
			}
		}
		else if errorlevel = 1
		{
			ToolTip, login2-error, 0, 0
			return False
		}	
	  }
	  else if errorlevel = 1
	  {
		ToolTip, login1-error, 0, 0
		return False
	  }
	}
	else if errorlevel = 1 
	{
		ToolTip, start-error, 0, 0
		return False
	}
	ToolTip, login Success, 0, 0	
}



semicolon_check(id){ ; with find_tree and find_training
	WinActivate, %id%
	sleep,1000
	refresh(id)
	loop, 10{
		ControlSend, , {;}, %id%
		sleep, 1
	}
	return True
	; if namu~ return bulmok ; image search message
	; else if namu~ return training
	; else false
}


server_reconn_check(id){
	WinActivate, %id%	
	sleep,1000
	ImageSearch, fx, fy, 0,0 , A_ScreenWidth, A_ScreenHeight, reconn.bmp
	if (errorlevel = 0) {
		tooltip, server_reconnection, 10, 10  ;msgbox, , , findit!
		; winkill, %id%
		return True
	}
	return False
}

server_check_sub:
	server_reconn_check_result = server_reconn_check()
	if (server_reconn_check_result){
		global server_flag = True
		msgbox, , , server_check_test_msgbox
		return
	}
	return

hit(id1,id2){
	WinActivate, %id1%
	sleep,1000
	refresh(id1)
	WinActivate, %id2%
	sleep,1000
	refresh(id2)
	; weather_off()
	sleep, 2000
	while True{
		loop, 9999{ 
			controlsend, , {space}{space}{space}, %id1% ; need to test for effectiveness
			sleep, 1 ; enough
			controlsend, , {space}{space}{space}, %id2% ; need to test for effectiveness
			sleep, 1 ; enough
		}
		server_status1 := server_reconn_check(id1)
		server_status2 := server_reconn_check(id2)
		if (server_status1 || server_status2)
			return False
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
		return True ; no map check
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
		return True
	}
	
  
	return False ;return find_training()
}




find_tree(id){
	WinActivate, %id%
	sleep,1000
	
	ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *20 tree.bmp
	if errorlevel = 0
	{
		mouseclick, left, fx+5, fy+25, 1
		sleep, 2000
		
		loop, 20
			controlsend, , {;} , %id% 
		sleep, 500
		ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
		if errorlevel = 0
			return True
		else{
			controlsend , , {DOWN}, %id% 
			loop, 20
				controlsend, , {;} , %id% 
			sleep, 500
		
			ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
			if errorlevel = 0
				return True
			else{
				controlsend , , {LEFT}, %id% 
				loop, 20
					controlsend, , {;} , %id% 
				sleep, 500
				ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
				if errorlevel = 0
					return True
				else{
					controlsend , , {UP}, %id% 
					loop, 20
						controlsend, , {;} , %id% 
					sleep, 500
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr2.bmp
					if errorlevel = 0
						return True
					else{
						controlsend , , {RIGHT}, %id% 
						loop, 20
							controlsend, , {;} , %id% 
					}
					sleep, 500
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


find_training(id){
	WinActivate, %id%
	sleep,1000
	
	ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *20 training.bmp
	if errorlevel = 0
	{
		mouseclick, left, fx+5, fy+25, 1
		sleep, 2000
		
		loop, 20
			controlsend, , {;} , %id% 
		sleep, 500
		ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
		if errorlevel = 0
			return True
		else{
			controlsend , , {DOWN}, %id% 
			loop, 20
				controlsend, , {;} , %id% 
			sleep, 500
		
			ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
			if errorlevel = 0
				return True
			else{
				controlsend , , {LEFT}, %id% 
				loop, 20
					controlsend, , {;} , %id% 
				sleep, 500
				ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
				if errorlevel = 0
					return True
				else{
					controlsend , , {UP}, %id% 
					loop, 20
						controlsend, , {;} , %id% 
					sleep, 500
					ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  corr1.bmp
					if errorlevel = 0
						return True
					else{
						controlsend , , {RIGHT}, %id% 
						loop, 20
							controlsend, , {;} , %id% 
					}
					sleep, 500
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
	ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight,  moksuNPC.bmp
	if errorlevel = 0 
	{
		mouseclick, left, fx+5, fy+5, 3
		return True
	}
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
			find_tree_result  = find_tree(id)
			if (find_tree_result) {
				return True
			}
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
			find_tree_result  = find_tree(id)
			if (find_tree_result) {
				return True
			}
		}
	}
	return False
}


clean_process(){
	tooltip, clean_process, 0, 0
	loop, 6
		process, close, winbaram.exe
		
	send, #m
	send, #m
	return True
}



init_start(id1, id2){ 
	;msgbox, , %id1%
	ToolTip, start-winbaram, 0, 0
	send, #m
	start1 := start_winbaram(id1, "123123")
	WinWait, %id1%, , 60
	start2 := start_winbaram(id2, "123123")
	WinWait, %id2%, , 60
	start:= start1 && start2 ; AND Operation
	return start
}


;main
main(id1, id2)
{
	ToolTip, start-macro, 0, 0
	playing = true
	
	init_start_result := init_start(id1, id2)
	;msgbox % init_start_result
	if ( init_start_result := False ){
		ToolTip, start_winbaram-error, 0, 0
		return False ;clean()
	}
	else if ( init_start_result := True ){
		ToolTip, start_winbaram-success, 0, 0
		go_training_status := go_training(id1)
		go_tree_status := go_tree(id2)
		if (go_training_status is True ){	
			loop,6 { ; scenario 1
				find_training_status := find_training(id1)
				if (find_training_status ){
					break
				}
				go_training_status := go_training(id1)
			}
		}
		
		if (go_tree_status is True){
			loop,14 { ; scenario 1
				find_tree_status := find_tree(id2)
				if (find_tree_status ){
					break
				}
				go_tree_status := go_tree(id2)
			}
		}
		if ( find_training_status && find_tree_status) {
			while True{
				hit_result := hit(id1,id2)
				if (hit_result is False){
					return	
				}
			}
		}
		else{
			return
		}
	}
}





F1:: 
	settimer, server_check_sub, 5000 ;60000 
	while true{	
		if (clean_process()){
			if (global server_flag){
				msgbox , , , flag reset
				settimer, server_check_sub, off
				global server_flag = false
				goto, F1
			}
			main("카라", "끄아") ; send 다 아디로 
		}
		sleep, 15000 ; server reboot time
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
