ResizeWin(Width = 0,Height = 0)
{
  WinGetPos,X,Y,W,H,A
  If %Width% = 0
    Width := W

  If %Height% = 0
    Height := H

  WinMove,A,,%X%,%Y%,%Width%,%Height%
}

Run, notepad.exe

sleep 1000 ;winwait, °è»ê±â, , 1
;WinMove, A_ScreenWidth/2, 0, [100, 100] ; Move the window found by WinWait to the upper-left corner of the screen.
WinMove, 310, 130 ; Move the window found by WinWait to the upper-left corner of the screen.
resizewin(800,600)


; The following function centers the specified window on the screen:
CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}


