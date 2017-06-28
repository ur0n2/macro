	id_pw_set_result := True
	if (id_pw_set_result != False) {
		msg = [-] ID/PW SET FAILED
		msgbox, , , %msg% ;log(msg)		
	else {
		msg = [+] ID/PW SET SUCCESSED
		msgbox, , , %msg% ;log(msg)
	}