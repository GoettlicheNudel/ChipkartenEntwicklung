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
Public seenStr as String
Public seenLo as Long
Public oneBit as Long = 1
Public seenMask as Long
Public BitMask as Long

' Wait for a card
Call WaitForCard()
' Reset the card and check status code SW1SW2
ResetCard : Call CheckSW1SW2()

'Dauerschleife zu Testzwecken
While TRUE

Print "Bitte geben sie die Zahl der Sehenswürdigkeit ein: "

Line Input seenStr

seenLo = Val&(seenStr)
seenMask = oneBit Shl seenLo - 1

   Call SetBitMask(seenMask) : Call CheckSW1SW2()
   Call GetBitMasK(BitMask) : Call CheckSW1SW2()
   print BitMask
WEnd