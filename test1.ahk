/*
Run, calc.exe
winwait, 계산기, , 1
WinSetTitle, 계산기, , 계산기1
*/
sleep 1000
send, #r
sleep, 100
loop,10 
	send, {;}
	sleep, 100

ExitApp
send, {LWin down}r
send, {LWin up}
ExitApp


start1=True
start2=True
start:= start1 && start2
if (start = False)
	msgbox % start


Process, wait, Notepad.exe, 1
NewPID = %ErrorLevel%  ; Save the value immediately since ErrorLevel is often changed.
;msgbox % newpid
if ErrorLevel = 0
{
    ;MsgBox The specified process did not appear within 5.5 seconds.
    return
}


