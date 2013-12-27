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

Rem  Check that the application name is correct
Private Name$ : Call GetApplicationID (Name$) : Call CheckSW1SW2()
If Name$ <> ApplicationName$ Then Print "This is not a Tourist Card" : Exit

Private Age% : Call GetAge(Age%)

If SW1SW2 = NotPersonalised Then
  Print "Kundenkarte ist nicht Personalisiert!"
  Print "Bitte wenden Sie sich an die Touristeninformation."
  Exit
Else
   Print "Sie müssen mindestens 18 Jahre alt sein!"
   Print "Lese Daten..."
End If

If Age% < 3 Then 
   Print "Sie Sind nicht alt genug um diesen Dienst zu nutzen!"
Else 
   Print "Alter erfolgreich verifiziert!" 
End If

Exit