coordinate_recognition(num){
	ToolTip, coordinate_recognition, 0, 0
	path = C:\Users\ur0n2\Desktop\test\coordinate\
	ext = .bmp
	img = %path%%num%%ext%
	
	;tooltip, %img%, 0, 0
	;ImageSearch, fx, fy, 100,0,A_ScreenWidth, A_ScreenHeight,*20 %img%   ;917, 769, 928, 780, %img% 
	;ImageSearch, fx, fy, 913, 765, 927, 778, %img%
	ImageSearch, fx, fy, 913, 765, 927, 778,%img%
	
	if errorlevel = 0
	{
		msgbox, , , find
		MouseMove, fx, fy
	}
	else if errorlevel = 1
	{
		ToolTip, notfind, 0, 0
	}
}

CoordMode, mouse, screen
sleep, 1000

cnt=10
while(cnt>=0){
	coordinate_recognition(cnt)
	;tooltip, %cnt%, 0, 0
	cnt := cnt-1
}

; x1 x2 x3 y1 y2 y3 == X,Y coordinate move move ! 