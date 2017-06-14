ResizeWin(Width = 0,Height = 0)
{
	  WinGetPos,X,Y,W,H,A
	  If %Width% = 0
		Width := W

	  If %Height% = 0
		Height := H

	  WinMove,A,,%X%,%Y%,%Width%,%Height%
}
	
	
set_login(id, pw){ ; id list: kara, kka, vm1, vm2 
	sleep, 500
	send, %id%
	sleep, 500
	send, {tab}
	sleep, 500
	send, %pw%
	sleep, 500
	;send, {enter}			
	tooltip, input_id_pw_success, 0, 0
}

start_winbaram(id, pw)
{
	Run, "C:\Users\ur0n2\Desktop\123.lnk", , , pid1	
	Process, priority, %pid1%, High
	Winwait, Notice
	if (ErrorLevel = 0){
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
	  
	  WinSetTitle, 바람의 나라, , %id% 
	  winmove, %id%, , 0, 0
	  
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
	  ToolTip, start-error, 0, 0
	  return False

	ToolTip, login Success, 0, 0	
}



set_window_xy(){

}



semicolon_check(what){]
	refresh()
	loop, 10
		send, {;}
		sleep, 100
	; if namu~ return bulmok ; image search message
	; else if namu~ return training
	; else false
}

server_reconn(){
	sleep 90000 ; wait for re-gen
	
}


go_training(){
  sleep, 500
  send, {ctrl down}e{ctrl up}
  sleep, 500
  send, {up}
  sleep, 500
  send, {up}
  sleep, 500
  send, {enter}
  sleep, 500
  send, {right}
  sleep, 500
  send, {enter}
  sleep, 500
  send, {right}
  sleep, 500
  send, {enter}
  sleep, 500
  ;주말평일구분
  
  return find_training()
}

go_tree(){
	; 벌목장이동
}

find_training(){
	; image 찾아서 클릭 
	; 이미지 보이면 클릭
	; return semicolon_check()
}

find_tree(){
}
set_option(){
	;옷벗기
	; 귓거부등 
	
}

clean(){
	return
  ; process-exit winbaram.exe
  ; 중복실행이 되지만 끄는게 나음
  ; 중복접속은안돼니 ㅋㅋ
  ; 
  
}

refresh(){
	sleep, 500
	send, {ctrl down}r
	send, {ctrl up}
	sleep, 200
	send, {ctrl down}r
	send, {ctrl up}
	sleep, 1000
}

go_smithy(){ ; 대장간
	
}


init_start(){
	start1 := start_winbaram("카라", "pass")
	start2 := start_winbaram("끄아", "pass")
	start:= start1 && start2 ; AND Operation
	return start
}



;main
^a::
loop{ 
	ToolTip, start-macro, 0, 0
	playing = true

	start = init_start()
	if ( start = False )
	{
		ToolTip, start_winbaram-error, 0, 0
		clean()
	}
	else if ( start = True )
	{
		ToolTip, start_winbaram-success, 0, 0
		; scheduling
		; go_training
		; go_tree
		; wait 5minute
		; check_reconn
		; 
	}
} 

^s::
ToolTip, end-macro, 0, 0
playing = false
ExitApp	
