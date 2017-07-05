log(sentence) {
	global log_dir = "asd.txt"
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%] %sentence%`n, %log_dir%
}


a := DllCall("IsHungAppWindow", "UInt", WinExist("Kingdom of the Winds"))
b := DllCall("IsHungAppWindow", "UInt", WinExist("winbaram"))
c := DllCall("IsHungAppWindow", "UInt", WinExist("바람의 나라"))
d := DllCall("IsHungAppWindow", "UInt", WinExist("카라"))
e := DllCall("IsHungAppWindow", "UInt", WinExist("끄아"))

;b:=1
log("start")
if (a || b || c || d || e) {
	log(hugapp)
	
	WinActivate, Kingdom of the Winds
	WinActivate, winbaram
	WinActivate, 바람의 나라
	WinActivate, 카라
	WinActivate, 끄아

	send, {ESC}
	send, {ESC}	
	send, {ESC}

	msg = %a%, %b%, %c%,  %d%, %e%
	log(msg)
}

if WinExist("Kingdom of the Winds") {	
	log("kingdom of the winds win title exist")	
	send, {ESC}
	send, {ESC}	
	send, {ESC}
	
}
