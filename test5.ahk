#WinActivateForce
global server_down_count = 0

test(){
	global server_down_count := server_down_count + 1
}

f2::
loop, 3
{
	msgbox, , , %server_down_count%
	test()
}
msgbox, , , %server_down_count%
f3::
	ExitApp