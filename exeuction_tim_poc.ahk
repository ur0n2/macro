global tick_timer = False


F1::
	Critical, OFF
	Critical
	startTime := A_TickCount ; 
	Critical, OFF
	
	sleep, 3000
	
	Critical
	minute := (A_TickCount - startTime) / 1000 / 60
	second := (A_TickCount - startTime) / 1000
	Critical, OFF
	msgbox , , ,  %minute%
	 FormatTime, %minute%, , s
	msgbox , , ,  %minute%
	; `n%second%
	/*
	msg = [*] RUNNING TIME %minute% m, (== %second% s)
	*/
	
F2::
	ExitApp
	
F3::
	Suspend