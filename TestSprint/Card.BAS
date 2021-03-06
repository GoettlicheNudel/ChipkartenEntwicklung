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

'Id dieser Karte
'Nur auslesbar
EEPROM ApplikationID as String = "Spielerkarte"

'Integer der ausgelesen/ver�ndert werden soll
EEPROM id as Integer = 0


'Gibt die Id der Karte als String zur�ck
Command &H88 &H00 GetApplikationID(LC=0, Data as String)
  Data=ApplikationID
End Command

'L�d den Wert der Integervariable und gibt ihn zur�ck
Command &H88 &H10 GetValue(LC=0, Data as Integer)
  Data=id
End Command

'Setzt die Integervariable der Karte auf den �bergebenen Wert
Command &H88 &H20 SetValue(Data as Integer, Disable LE)
  id=Data
End Command
