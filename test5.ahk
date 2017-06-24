
myip(){
	log("[+] GET MY IP")
	ip = %A_IPAddress1%
	return ip
}



F1:: 
	job_starter_id1_result := True
	msgbox % job_starter_id1_result
	
F2::
	ExitApp