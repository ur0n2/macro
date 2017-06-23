id_pw_set(){
	id1 = 1
	id1_pw = 2
	id2 = 3
	id2_pw = 4
	
}

global playing =0
global id1
global id1_pw
global id2
global id2_pw

F1::
	id_pw_set()
	msgbox, , , %id1%
	msgbox, , , %id2%
	msgbox, , , %id1_pw%
	msgbox, , , %id2_pw%
	
F2::
	ExitApp
/*
;global x := 20 
;return 
SetX(val){		
	global y =  30 ;  equally; y=30
	x:= x +val
	p:= p+1
	;msgbox, , , %y%
}

global p =0
	
F1::
	loop, 10
	{
	global y = 20
	global x = 0
	p := p +1
	msgbox, , , p is %p%
	SetX(10)
	;MsgBox,%x%
	;msgbox,y in f1: %y%
	y=40
	;msgbox,after y in f1: %y%
	}
F2::
	ExitApp
	
*/