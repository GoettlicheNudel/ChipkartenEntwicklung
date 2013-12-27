#include Card.def
#Include COMMANDS.DEF
#Include COMMERR.DEF
#include MISC.DEF
#Include CARDUTIL.DEF


Private cardCount as Integer ' Anzahl der gelesenen Karten
Private AgeSum as Long ' Summe der ausgelesenen Altersgruppen
Private BonusSum as Long ' Summe der ausgelesenen Bonuspunkte
Private AttractionsSum as Long ' Summe der besuchten Sehenswürdigkeiten
Private AttAgeSums(0 To 31) as Long ' Array mit den Summen der der Altersgruppe von besuchten Sehensw.
Private AttVisitors(0 To 31) as Integer ' Array mit Anzahl der Besucher je Sehensw.

Private opt as Integer ' Werte für Optionsmenü und Schleifen
Private I as Integer
Private J as Integer

Start:

Print "Bitte Funktion wählen: "
Print "0: Karte Einlesen"
Print "1: Statistik ausgeben"
Input opt As Integer

IF opt < 1 THEN 
   GoTo ReadCard 
Else 
   GoTo PrintStat 
End IF

ReadCard:
' Wait for a card
Call WaitForCard()
' Reset the card and check status code SW1SW2
ResetCard : Call CheckSW1SW2()


Rem  Test auf korrekte Application-ID
Private Name$ : Call GetApplicationID (Name$) : Call CheckSW1SW2()
If Name$ <> ApplicationName$ Then Print "This is not a Tourist Card" : GoTo NoCard ' False ID -> Beende Ausführung

Rem Vor Einfluss der Daten in die Statistik, erst alle dafür erforderlichen Daten von Karte auslesen
Private Age% : Call GetAge(Age%) ' Alter einlesen

If SW1SW2 = NotPersonalised Then ' Karte nicht personnalisiert -> Beende Ausfürung
  Print "Karte nicht personalisert!"
  Print "Bitte wenden Sie sich an die Kundeninformation."
  GoTo NoCard
End If

ReadSights:

ResetCard
If SW1SW2 = swNoCardInReader Then ' Sollte während dem Einlesen die Karte gezogen werden -> Beende Ausführung
   Print "Karte wurde vorzeitig entfernt."
   Print "Kundendaten fließen nicht in Statistik ein!"
   GoTo Start
End If

Private Bonus% : Call ReadBonus(Bonus%) : ResetCard ' Einlesen der Bonuspunkte

If SW1SW2 = swNoCardInReader Then ' Sollte während dem Einlesen die Karte gezogen werden -> Beende Ausführung
   Print "Karte wurde vorzeitig entfernt."
   Print "Kundendaten fließen nicht in Statistik ein!"
   GoTo Start
End If

Rem Temporäre Variablen für Berechnungen der Statistik
Private sightsValue as Long
Private shiftValue as Long
Private seenSights as Integer

Call GetBitMasK(sightsValue) : ResetCard ' Einlesen der besuchten Sehenswürdigkeiten
If SW1SW2 = swNoCardInReader Then ' Sollte während dem Einlesen die Karte gezogen werden -> Beende Ausführung
   Print "Karte wurde vorzeitig entfernt."
   Print "Kundendaten fließen nicht in Statistik ein!"
   GoTo Start
End If

cardCount = cardCount + 1 ' Counter erhöhen
AgeSum = AgeSum + Age% ' Alter des Kunden zur Summe addieren
BonusSum = BonusSum + Bonus% ' Bonuspunkte des Kunden zur Summe addieren

FOR I = 0 TO 31 ' Berechnung der Altersstatistik der Sehenswürdigkeiten
   shiftValue = sightsValue

   shiftValue = shiftValue Shl (31 - I) ' Shiften der Bit-Werte der Sehenswürdigkeiten
   shiftValue = shiftValue SHr 31
   
   IF shiftValue <> 0 Then ' Setzen der Array-Werte des besuchten Sehensw.
      AttAgeSums(I) = AttAgeSums(I) + Age%
      AttVisitors(I) = AttVisitors(I) + 1
   End If
   
   seenSights = seenSights + shiftValue 
Next

AttractionsSum = AttractionsSum + seenSights * -1
   seenSights = 0

GoTo NoCard

PrintStat: ' Label für Ausgabe der Statistik

If cardCount = 0 Then ' Falls noch keine Daten vorhanden -> Warnung ausgeben
   Print "Noch keine Daten vorhanden!"
   GoTo Start
End If

Rem Berechnen der Werte und Ausgabe auf dem Terminal
Print "Durchschnittliche Altersgruppe der Kunden: "; AgeSum / cardCount
Print "Durchschnittliche Bonuspunkte je Kunde: "; BonusSum / cardCount
Print "Durchschnittliche Anzahl besuchter Sehenswuerdigkeiten je Kunde: "; AttractionsSum / cardCount
Print "Durchschnittliche Altersgruppe der Kunden je Sehenswuerdigkeit: "

Private graphLine as String ' String mit Zeile des Graphen

Rem Erstellung einzelner Zeilen für den Graphen + Ausgabe
FOR I = 0 TO 9
   FOR J = 0 TO 31
      If AttVisitors(J) <> 0 Then ' Falls Wert in dieser Zeile vorkommt, füge Zeichen hinzu
         If AttAgeSums(J)/AttVisitors(J) = (9 - I) Then
            graphLine = graphLine + "o"
         Else
            graphLine = graphLine + "_" ' Ansonsten nur filler einfügen
         End If
      Else
         graphLine = graphLine + "_"
      End If
   Next
   
   Print 9 - I; graphLine
   graphLine = ""
Next
   Print "Nr:123456789|123456789|123456789|12" ' Skala

GoTo Start


NoCard:
Print "Bitte Karte entnehmen"
WaitForNoCard
GoTo Start