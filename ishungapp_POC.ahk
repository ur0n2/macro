log(sentence) {
	global log_dir = "asd.txt"
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%] %sentence%`n, %log_dir%
}


a := DllCall("IsHungAppWindow", "UInt", WinExist("Kingdom of the Winds"))
b := DllCall("IsHungAppWindow", "UInt", WinExist("winbaram"))
c := DllCall("IsHungAppWindow", "UInt", WinExist("�ٶ��� ����"))
d := DllCall("IsHungAppWindow", "UInt", WinExist("ī��"))
e := DllCall("IsHungAppWindow", "UInt", WinExist("����"))

;b:=1
log("start")
if (a || b || c || d || e) {
	log(hugapp)
	
	WinActivate, Kingdom of the Winds
	WinActivate, winbaram
	WinActivate, �ٶ��� ����
	WinActivate, ī��
	WinActivate, ����

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
