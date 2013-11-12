Option Explicit

#include Card.def
#Include COMMANDS.DEF
#Include COMMERR.DEF
#include MISC.DEF
#Include CARDUTIL.DEF

'  Execution starts here

' Wait for a card
Call WaitForCard()
' Reset the card and check status code SW1SW2
ResetCard : Call CheckSW1SW2()

' A String variable to hold the response
Public Data$

'Dauerschleife zu Testzwecken
While TRUE

'Hole die Id der Karte
Call WaitForCard()
Call GetApplikationID(Data$) : Call CheckSW1SW2()

'Wenn der Name flasch ist Beende das Programm
If Data$ = "Spielerkarte" Then
print "Id korrekt"
Else
print "Error"
Exit
End If


print "Was wollen sie tun?"
print "1. i auslesen"
print "2. i überschreiben"


'Eingabe des Befehls durch den Nutzer
Public in as String
Public idInt as Integer
Line Input in

'Wandel String zu Integer
idInt = Val&(in)
Public intRead

'Führe den passenden Befehl zu Id aus
Select Case idInt
'Case 1 Integer auslesen
Case 1
   Call WaitForCard()
   Call getValue(intRead) : Call CheckSW1SW2()
   print intRead
   Exit Case
'Case 2  Alten Wert mit neuem überschreiben
Case 2
   print "Geben sie den neuen Wert ein"
   'Erneut String einlesen
   Line Input in
   'In Integer umwandeln
   idInt = Val&(in)
   'Neuen Wer auf die Karte schreiben
   Call WaitForCard()
   Call SetValue(idInt) : Call CheckSW1SW2()
   Exit Case
 Case Else
   print "Kein Befehls mit dieser Id gefunden"
   Exit Case
End Select
WEnd