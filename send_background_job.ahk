
hit(id){
	;msgbox, , %id%, ; tooltip,  %id%, 10,10
	sign = false
	loop{ 
		if sign = true
			return
		controlsend, , 123123{space}, %id% ; test.txt
		sleep 10 ; enough
	}
}

F1::
hit("test.txt")

F2::
sign = treu
ExitApp

/*
F1::
	sign = false
	loop{ 
		if sign = true
			break
		;tooltip, asfasfas,110,110 
		controlsend, , {space}, test.txt
		sleep 10 ; enough
	}
	return


F2::
sign = true
ExitApp

F3::
controlsend, , {p down}, test.txt
;PostMessage, 0x31, wParam, lParam, , tete
;PostMessage, ss0x31, 0, 0, tete

*/