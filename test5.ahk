
myip(){
	log("[+] GET MY IP")
	ip = %A_IPAddress1%
	return ip
}



F1:: 
	
	FileGetSize, last_log_file_size,  .\\log\\log0.txt, K	
	msgbox % last_log_file_size
	
F2::
	ExitApp