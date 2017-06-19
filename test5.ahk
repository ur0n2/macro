sleep, 1000

WinActivate, ²ô¾Æ
controlsend, , n, %id% ; name remove
;loop, 17
;	controlsend, , {RIGHT} , %id% ; just

ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree.bmp
if ErrorLevel != 0 
{
	ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree1.bmp
	if ErrorLevel != 0 
	{
		ImageSearch, fx, fy, 0,0, A_ScreenWidth, A_ScreenHeight,  *30 tree2.bmp
		if ErrorLevl != 0 
		{
			msgbox, , , , no find
		}
	}
}

if errorlevel = 0
{
	mousemove, fx+27, fy+40 ; mouseclick, left, fx+2, fy+2, 1

}	