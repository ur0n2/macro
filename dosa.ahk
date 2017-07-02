id1=²ô¾Æ 


F3::
	while, 100
	{
		loop, 5
		{
			controlsend, , 2,%id1%
			sleep, 15	0
			;controlsend, , {ENTER},%id1%		
			;sleep, 170	
		}
		sleep, 50
		controlsend, , 3, %id1%
		;controlsend, , 3, %id1%
		sleep, 10
	}
	
F4::
	ExitApp