sleep, 1000
CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/16), (A_ScreenHeight/2)-(Height/2)
}
Run, "C:\Users\ur0n2\Desktop\123.lnk", , , pid1	
Process, priority, %pid1%, High
Winwait, Notice
centerwindow(notice)