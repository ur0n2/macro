myip(){
	;log("[+] GET MY IP")
	ip = %A_IPAddress1%
	return ip
}

CountSubstring(fullstring, substring){
   StringReplace, junk, fullstring, %substring%, , UseErrorLevel
   return errorlevel
}

IniRead, OutputVarSectionNames, machine_config.ini
;MsgBox, %OutputVarSectionNames%
section_count := countSubstring(OutputVarSectionNames, "machine") 
msgbox, section_count: %section_count%

loop, %section_count% {
	IniRead, ip, machine_config.ini, machine%A_Index%, ip
	IniRead, id1, machine_config.ini, machine%A_Index%, id1
	IniRead, id1_pw, machine_config.ini, machine%A_Index%, id1_pw	
	IniRead, id1_job, machine_config.ini, machine%A_Index%, id1_job
	IniRead, id2, machine_config.ini, machine%A_Index%, id2
	IniRead, id2_pw, machine_config.ini, machine%A_Index%, id2_pw	
	IniRead, id2_job, machine_config.ini, machine%A_Index%, id2_job
	IniRead, winbaram_path, machine_config.ini, machine%A_Index%, winbaram_path		
	local_ip := myip()	
	;msgbox, %local_ip%	
	if ( ip = local_ip) {
		msg =  [+] MACHINE CONFIG: %ip% %id1% %id1_pw% %id1_job% %id2% %id2_pw% %id2_job% %winbaram_path%
		;log(msg)
		msgbox, , , %msg%
	}
} 




; ref; https://www.rosettacode.org/wiki/Count_occurrences_of_a_substring#AutoHotkey


/*  
Match.Count()
asd := RegExMatch("xxxabc123xyzabc", "abc")
msgbox, , , %asd%

str = the dog went for a run with another dog
match = dog

msgbox % "Found " ( count, regexReplace( str
	 , "(" match ")", match, count ))
	 . " instance" ( count!=1 ? "s" : "" )
	 . " of " match "."
	 
	 str  := "the dog went for a run with another dog"
match = dog
StringReplace, str, str, %match%, %match%, UseErrorLevel
msgbox, %ErrorLevel%


Indentation := "aaavis"



RegExMatch(Indentation, "O)(a)(a)(a)", ona)

MsgBox % ona[1] ; array

MsgBox % ona.Count()



/*
id_pw_set(){
ip := myip()

if (ip = "192.168.57.5"){ ; lg
	id1 = Ä«¶ó
	id1_pw = 123123
	id1_job = training
	id2 = ²ô¾Æ
	id2_pw = 123123
	id2_job = tree
	winbaram_path =  C:\Users\ur0n2\Desktop\123.lnk
}
else if (ip =  "203.250.148.136") { ;136vm
	id1 = ¼Õ³ªÀº
	id1_pw = apfhd
	id1_job = tree
	id2 = À±¾Æ
	id2_pw = apfhd
	id2_job = tree
	winbaram_path = C:\Users\ur0n2\Desktop\123.lnk
}
else {
	msg = [-] IP NOT FIND
	log(msg)
	ExitApp
}
}

ip all delete

*/