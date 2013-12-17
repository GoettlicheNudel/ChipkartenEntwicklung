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

' Wait for a card
Call WaitForCard()
' Reset the card and check status code SW1SW2
ResetCard : Call CheckSW1SW2()

Public id&
Public fares%

Call GetCardId(id&) : Call CheckSW1SW2()

print "Card Id ist: "
print id&

Call GetBusFares(fares%) : Call CheckSW1SW2()
print ""
print "Sie sind bereits: "
print fares%
print "gefahren"



