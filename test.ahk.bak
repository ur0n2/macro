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
	Winwait, Notice
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



server_reconn(){
	
}

working_schedule(){
	
}

search_tree(){

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
  
  
}

set_option(){
	;옷벗기등
	
}

clean(){
  ; process-exit winbaram.exe
}
go_smithy(){
	
}




;main
^q::
go_training()

^a:: 
ToolTip, start-macro, 0, 0
playing = true

start := start_winbaram("카라", "pass")
if ( start = False)
{
	ToolTip, start_winbaram-error, 0, 0
	clean()
}
else if ( start = True)
{
	ToolTip, start_winbaram-success, 0, 0
	; scheduling
}
loop{ 
	sleep, 63000
} 
return 


^s::
ToolTip, end-macro, 0, 0
playing = false
ExitApp	
