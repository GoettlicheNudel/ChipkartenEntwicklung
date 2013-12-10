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

#IfDef MultiAppBasicCard
  ' This section is required for MultiApplication BasicCards only
  ' it is ignored for Enhanced and Professional BasicCards
  #Include COMPONNT.DEF
  Dir "\"
    Application "DefaultApp" ' Make this the Default Application
      Lock=Execute:Always
  End Dir
#EndIf

' This variable is of storage type EEPROM
' and thus persistent
Eeprom Personalised = False
EEPROM BonusPoints as Integer
EEPROM AgeRange as Integer = 3' The age range of the card user (0-9)
EEPROM Viewed as Long



' This command saves Data in EEPROM.
' Since no output data is required, LE is disabled
Command &H88 &H42 WriteBonus(Data as Integer, Disable LE)
   ' Just copy it to EEPROM variable to save it
   BonusPoints=Data
End Command

' This command reads data written by WriteData and 
' returns this data in response.
' Since no input data is required, LC is set to 0
Command &H88 &H44 ReadBonus(LC=0, Data as Integer)
   Data=BonusPoints
End Command

Command &H88 &H40 GetAge(LC=0, Data as Integer)
  If Not Personalised Then SW1SW2 = NotPersonalised : Exit
  Data=AgeRange
End Command

Command &H88 &H46 GetBitMasK(LC=0, Data as long)
  Data=Viewed
End Command

Command &H88 &H48 SetBitMask(Data as long, Disable LE)
  Viewed = Viewed OR Data
End Command