
hit(){
	while true	{
		controlsend, , {space}{space}{space}, 바람의 나라  ; need to test for effectiveness
		sleep, 1 ; enough
	}
}



F2::
ExitApp

F1::
a:= 6
loop, 6 {
	msgbox, , %a%
	if (a < 3){
		break
	}
	a:=a-1
}

L1:
	msgbox, , "continue"
	return