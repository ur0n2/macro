FormatTime, now_time,, HHmm ;HH:mm:ss
FormatTime, test, HHmm
msgbox , , ,%test%
	
;msgbox , , , %now_time%
if now_time >= 1100 && now_time <=1105
	msgbox , , , showtime
else
	msgbox, , , nothing 
;for event time check