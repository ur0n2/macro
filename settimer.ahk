#Persistent
global flag = False

server_reconn_check(){
	msgbox, , , server_checking...
	return True
}

server_check_sub:
	msgbox, , , server_check_sub
	server_reconn_check_result = server_reconn_check()
	if (server_reconn_check_result){		
		msgbox, , , server_check_test_msgbox
		global flag = True
		return ; goto F1 ;return
	}
	return


F1::
	SetTimer, server_check_sub, 5000
	while True{	
		msgbox, , %flag%
		if (global flag){
			msgbox , , , flag reset
			settimer, server_check_sub, off
			global flag = False
			goto, F1
		}
		sleep, 500
	}
	return



F2::
ExitApp



/*
#Persistent

F1::
	SetTimer, server_check_sub, 4000
	while True{	
		msgbox, , practice-check
		sleep, 500
	}
	return


server_reconn_check(){
	msgbox, , , server_checking...
	return True
}

server_check_sub:
	msgbox, , , server_check_sub
	server_reconn_check_result = server_reconn_check()
	if (server_reconn_check_result){		
		msgbox, , , server_check_test_msgbox
		return ; goto F1 ;return
	}
	return


F2::
ExitApp
*/