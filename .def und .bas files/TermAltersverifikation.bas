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

If SW1SW2 = NotPersonalised Then
  Print "Card has not been personalised!"
  Print "Please contact the Tourist Support."
  Exit
Else
   Print "Card is personalised."
   Print "You need to be at least 18 years old to use this terminal."
   Print "Reading Age Data."
End If

Private Age% : Call GetAge(Age%) : Call CheckSW1SW2()
If Age% < 3 Then 
   Print "You are not old enough to use this service or terminal."
Else 
   Print "Age successfully verified." 
End If

Exit