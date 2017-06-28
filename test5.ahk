#Persistent

check(){
	msgbox, , , check
}

check1(){
	msgbox, , , check1
}


F1::
	settimer, check1, 2000
	msgbox, , , test


F2::
	ExitApp


F3::
	while True {
		controlsend, , {p down}, test.txt
		sleep, 1000
	}
	
F4::
	Pause, ON
F6::
	Pause, OFF

	