reconn()
{
	ImageSearch, fx, fy, 0,0 , A_ScreenWidth, A_ScreenHeight, reconn.bmp
	if (errorlevel = 0) {
		msgbox, , , findit!
		winkill, �ٶ��� ����
	}
}

F3::
send, #m
F1::

	Loop{
		controlsend, , {space} {space} {space} {space} {space} {space} {space}, �ٶ��� ����		;�; need to test for effectivenes
		sleep, 1
		reconn()
}

F2::
ExitApp