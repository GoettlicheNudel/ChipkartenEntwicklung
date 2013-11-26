Rem BasicCard Sample Source Code Template
Rem ------------------------------------------------------------------
Rem Copyright (C) 2008 ZeitControl GmbH
Rem You have a royalty-free right to use, modify, reproduce and 
Rem distribute the Sample Application Files (and/or any modified 
Rem version) in any way you find useful, provided that you agree 
Rem that ZeitControl GmbH has no warranty, obligations or liability
Rem for any Sample Application Files.
Rem ------------------------------------------------------------------
Option Explicit

#include Card.def
#Include COMMANDS.DEF
#Include COMMERR.DEF
#include MISC.DEF
#Include CARDUTIL.DEF

'  Execution starts here

Public Data
Public In

Begin:
' Wait for a card
Call WaitForCard()
' Reset the card and check status code SW1SW2
ResetCard : Call CheckSW1SW2()


print "Bitte geben Sie den Wert ein: "
Input In As Integer



Call ReadBonus(Data) : Call CheckSW1SW2()

print "Bonuspunkte vorher: "; Data

If -In > Data Then
print "Leider haben Sie nicht genügend Punkte auf der Karte."
GoTo NotEnough
End If

' Call the command to write data and check the status

CardInReader
Call WriteBonus(Data+In) : Call CheckSW1SW2()
' Just for test change value of Data$

' Call the command to read back data and check the status
Call ReadBonus(Data) : Call CheckSW1SW2()
' Ouput the data
print "Bonuspunkte aktuell: "; Data
print "Bitte entnehmen Sie Ihre Karte."
WaitForNoCard
print "Vielen Dank, Bitte beehren Sie uns bald wieder."
GoTo Begin

NotEnough:
print "Bitte entnehmen Sie Ihre Karte."
WaitForNoCard
print "Einen schönen Tag noch."
GoTo Begin