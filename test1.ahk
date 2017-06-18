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
  
  WinSetTitle, 바람의 나라, , kara
  winmove, kara, , 0, 0
  
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
			send, 카라
			sleep, 500
			send, {tab}
			sleep, 500
			send, 123123
			sleep, 500
			;send, {enter}			
			tooltip, login Success !, 0, 0
		}
		else if errorlevel = 1
		{
			ToolTip, login1-error, 0, 0
		}
	}
	else if errorlevel = 1
	{
		ToolTip, login2-error, 0, 0
	}	
  }
  else if errorlevel = 1
  {
    ToolTip, login1-error, 0, 0
  }
}
else if errorleve =0 
  ToolTip, start-error, 0, 0

ToolTip, login Success, 0, 0
