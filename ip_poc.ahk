id_pw_set(){
	myip = %A_IPAddress1%
	return myip
}

a := id_pw_set()
if ( a= "192.168.57.5") {
	msgbox ,, , yes
}
msgbox, , , %a%