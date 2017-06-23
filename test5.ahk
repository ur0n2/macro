
myip(){
	log("[+] GET MY IP")
	ip = %A_IPAddress1%
	return ip
}



F1:: 
	msg = [+] START TO FB MACRO [%playing% DONE] - myip()
	msgbox % msg
F2::
	ExitApp