#Persistent

SetTimer, F1, 500
return


F1::

;SetTimer, Alert1, Off  ; i.e. the timer turns itself off here.
msgbox,  , The video conversion is finished.
return

F2::
ExitApp
