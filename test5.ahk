;No response PoC


if  winexist("Kingdom of")  { ; Test Pass
	WinActivate, Kingdom of
	send, {ESC}
}
if winexist("AutoHotkey Unicode") { ; test  not yet
	WinActivate, AutoHotkey Unicode
	send, {ESC}
}