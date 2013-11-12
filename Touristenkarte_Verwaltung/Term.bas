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

' Test Hello World command
' A String variable to hold the response
Public Data$
' Call the command and check the status
Call HelloWorld(Data$) : Call CheckSW1SW2()
' Output the result
print Data$

' Test to store some data
' Set the value to store
Data$="I can keep this information"
' Call the command to write data and check the status
Call WriteData(Data$) : Call CheckSW1SW2()
' Just for test change value of Data$
Data$="You will not see this"
' Call the command to read back data and check the status
Call ReadData(Data$) : Call CheckSW1SW2()
' Ouput the data
print Data$
