id_pw_set(){
	myip = %A_IPAddress1%
	return myip
}

a := id_pw_set()
msgbox, , , %a%